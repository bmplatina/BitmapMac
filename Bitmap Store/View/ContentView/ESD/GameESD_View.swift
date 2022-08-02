//
//  SoftwareDistributionView.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/18.
//

import SwiftUI
import URLImage
import YouTubePlayerKit

struct GameESD_View: View {
    @State private var searchField: String = ""
    @ObservedObject var gameViewmodel = gameInfoViewmodel()
    
    var isFromSidebar: Bool
    
    let gameInfoExam = exampleGameInfo()
    let columnLayout = Array(repeating: GridItem(), count: 4)
    
    var body: some View {
        VStack {
            if isFromSidebar {
                ZStack {
                    Rectangle()
                        .fill(Color.init(hex: "4CAF5D"))
                        .frame(height: 42)
                        .shadow(radius: 4)
                    HStack {
                        Spacer()
                        Image("bitmapWebLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        Spacer()
    //                    if true {
    //                        Text("Online")
    //                    }
    //                    else {
    //                        Text("Offline Mode")
    //                    }
                        TextField("Filter".localized(), text: $searchField)
                    }
                }
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Seoul Institute of the Arts Collection")
                        .font(.largeTitle)
                        .bold()
                        .padding([.top, .leading])
                    Text("서울예술대학교 디지털아트전공 학생들의 각종 게임 전시작을 한눈에.")
                        .padding(.leading)
                    Divider()
                        .padding()
                    LazyVGrid(columns: columnLayout, alignment: .center, spacing: 2) {
                        // List(gameViewmodel.gameInfos) { aGameInfos in }
                        ForEach(0..<gameViewmodel.gameInfos.count, id: \.self) { aGameInfos in
                            GameButtons(gameViewmodel.gameInfos[aGameInfos])
                        }
                    }
                    Divider()
                        .padding()
                }
            }
            .navigationTitle(isFromSidebar ? "Games".localized() : "Explore".localized())
        }
    }
}

struct GameButtons: View {
    @State private var showingPopover = false   // Showing pop-ups for game details view
    @State private var installAlert = false     // Showing Install Wizard
    @State private var uninstallAlert = false   // Showing Uninstall Wizard
    @State private var showProgressBar = true
    @State private var showUnsupportedPlatformAlert = false
    @State private var progressBarValue = 0.0   // Progress bar value
    @State private var forceMacSupport = false
    
    var gameInfos: gameInfo
    
    init(_ gameInfos: gameInfo) {
        self.gameInfos = gameInfos
    }
    
    var body: some View {
        Button {
            showingPopover = true
        } label: {
            ZStack {
                Image("unknownImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                URLImage(URL(string: gameInfos.gameImageURL)!) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width:300)
                }
                LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom).frame(width: 300, height: 424)
                VStack(alignment: .leading) {
                    Spacer()
                    HStack {
                        Text(gameInfos.gameTitle)
                            .foregroundColor(.white)
                            .font(Font.largeTitle)
                            .bold()
                        if gameInfos.gamePlatformWindows {
                            Image("platformWindows10")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .foregroundColor(.white)
                        }
                        if gameInfos.gamePlatformMac {
                            Image("platformApple")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .foregroundColor(.white)
                        }
                        if gameInfos.gamePlatformMobile {
                            Image("platformAndroid")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .foregroundColor(.white)
                            Image("platformIOS")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .foregroundColor(.white)
                        }
                    }
                    Text(gameInfos.gameGenre)
                        .foregroundColor(.white)
                    Divider()
                    Text("Dev".localized() + ": " + gameInfos.gameDeveloper)
                        .foregroundColor(.white)
                }
                .frame(width:256)
                .padding()
            }
            .cornerRadius(24)
            .shadow(radius: 4)
            .padding()
        }
        .buttonStyle(GrowingImageButton())
        .sheet(isPresented: $showingPopover) {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: { showingPopover = false }) {
//                        Image(systemName: "x.circle")
//                            .font(.title2)
                        Circle()
                            .fill(Color(hex: "ff5f57"))
                            .frame(width:12.5)
                    }
                    .background(Color(hex: "ff5f57"))
                    .clipShape(Circle())
                    .buttonStyle(PlainButtonStyle())
                    .padding([.leading, .bottom, .trailing], 1)
                    Circle()
                        .fill(Color(hex: "625b5b"))
                        .frame(width:12.5)
                        .padding([.bottom, .trailing], 1)
                    Circle()
                        .fill(Color(hex: "625b5b"))
                        .frame(width:12.5)
                        .padding([.bottom, .trailing], 1)
                    Spacer()
                    VStack(alignment: .center) {
                        Text("Bitmap Store".localized() + ": " + gameInfos.gameTitle)
                            .bold()
                    }
                    Spacer()
                }
                .padding()
// MARK: Sheets for Detail View and Installation Wizard
                VStack(alignment: .leading) {
                   HStack {
                       ZStack {
                           Rectangle()
                               .opacity(0)
                               .frame(width: 256, height: 256)
                               .padding()
                           URLImage(URL(string: gameInfos.gameImageURL)!) { image in
                               image
                                   .resizable()
                                   .scaledToFit()
                                   .frame(width: 256)
                                   .cornerRadius(24)
                                   .shadow(radius: 4)
                                   .padding()
                           }
                       }
                       Divider()
                       VStack(alignment: .leading) {
                           HStack {
                               Text(gameInfos.gameTitle)
                                   .font(Font.largeTitle)
                                   .bold()
                               if gameInfos.isEarlyAccess {
                                   Text("EARLY ACCESS".localized())
                                       .padding(.top, 7)
                               }
                           }.padding(.leading)
                           HStack {
                               if gameInfos.gamePlatformWindows {
                                   Image("platformWindows")
                                       .resizable()
                                       .scaledToFit()
                                       .frame(height: 25)
                                       .foregroundColor(.white)
                               }
                               if gameInfos.gamePlatformMac {
                                   Image("platformApple")
                                       .resizable()
                                       .scaledToFit()
                                       .frame(height: 25)
                               }
                               if gameInfos.gamePlatformMobile {
                                   Image("platformAndroid")
                                       .resizable()
                                       .scaledToFit()
                                       .frame(height: 25)
                                       .foregroundColor(.white)
                                   Image("platformIOS")
                                       .renderingMode(.template)
                                       .resizable()
                                       .scaledToFit()
                                       .frame(height: 25)
                                       .foregroundColor(Color.init(hex: "0078d4"))
                               }
                           }.padding([.leading, .bottom])
                           Text("Released on".localized() + ": " + gameInfos.gameReleasedDate)
                               .padding(.leading)
                           Text("Genre".localized() + ": " + gameInfos.gameGenre)
                               .padding(.leading)
                           Text("Developer".localized() + ": " + gameInfos.gameDeveloper)
                               .padding(.leading)
                           Text("Publisher".localized() + ": " + gameInfos.gamePublisher)
                               .padding(.leading)
                           Link("Visit game website".localized(), destination: URL(string: gameInfos.gameWebsite)!)
                               .padding(.leading)
                           Divider()
                               .padding()
                           ScrollView {
                               Text(gameInfos.gameHeadline)
                                   .font(Font.largeTitle)
                                   .bold()
                                   .padding()
                               // YouTubePlayerView("https://www.youtube.com/watch?v=WSLxwXMwIog").frame(width:200)
                               Text(gameInfos.gameDescription)
                           }.padding()
                       }
                   }
                   
                   Spacer()
                   
                    if gameInfos.gamePlatformMac || forceMacSupport {
                       switch true {
                       case true:
                           HStack {
                               Button(action: {
                                   // runCommand(command: "open \"" +  gameInfos.gameInstallationPathMac + "\"")
                               }) {
                                   if forceMacSupport {
                                       Text("Open".localized())
                                           .font(.title3)
                                   }
                                   else {
                                       Text("Play".localized())
                                           .font(.title3)
                                   }
                               }
                               .padding()
                               .buttonStyle(GrowingButton())
                               Button(action: { uninstallAlert = true }) {
                                   Text("Uninstall".localized())
                                       .font(.title3)
                               }
                               .alert(isPresented: $uninstallAlert) {
                                   Alert(
                                    title: Text(gameInfos.gameTitle + " will be removed from your computer".localized()),
                                    message: Text(gameInfos.gameTitle + " will be deleted from your system. It cannot be undone.".localized()),
                                    primaryButton: .destructive(
                                        Text("Delete".localized()), action: {
                                            // runCommand(command: "rm -rvf \"" +  gameInfos.gameInstallationPathMac + "\"")
                                    }),
                                    secondaryButton: .default(
                                        Text("Cancel".localized())
                                    ))
                               }
                               .padding()
                               .buttonStyle(GrowingButton())
                               if showProgressBar {
                                   ProgressView("Downloading".localized(), value: progressBarValue, total:100)
                                       .progressViewStyle(LinearProgressViewStyle())
                                       .padding()
                               }
                           }
                       case false:
                           Button(action: { installAlert = true }) {
                               Text("Install".localized())
                                   .font(.title3)
                           }
                           .alert(isPresented: $installAlert) {
                               Alert(title: Text(gameInfos.gameTitle + " will be installed".localized()), message: Text("Bitmap Store couldn't reach to server. Please check your internet connection.".localized()), dismissButton: .default(Text("Dismiss")))
                           }
                           .padding()
                           .buttonStyle(GrowingButton())
                       }
                   }
                   else {
                       Button(action: {
                           showUnsupportedPlatformAlert = true
                       }, label: {
                           Text("Unsupported Platform".localized())
                       })
                       .padding()
                       .buttonStyle(GrowingButton())
                       .alert(isPresented: $showUnsupportedPlatformAlert) {
                           Alert(
                            title: Text("Unsupported Platform".localized()),
                            message: Text(gameInfos.gameTitle + " is not playable for Mac. But in case, if you are using Apple Silicon Mac for iOS support, or have emulator installed for Windows and Android support, you may play this game. Do you want to install anyway?".localized()),
                            primaryButton: .default(
                                Text("Confirm".localized()), action: {
                                    forceMacSupport = true
                            }),
                            secondaryButton: .default(
                                Text("Cancel".localized())
                            ))
                       }
                   }
                   
               }
            }
            .frame(width: 1280, height: 800)
            .fixedSize()
        }
    }
    
    func runCommand(command: String) {
        DispatchQueue.global().async {
            let task = Process()
            task.launchPath = "/bin/zsh"
            task.arguments = ["-c", command]
            task.launch()
            task.waitUntilExit()
        }
    } // https://seorenn.github.io/note/swift-howto-run-shell-command.html
    func runAppByBundleIdentifier(identifier: String) {
        guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: identifier) else { return }

        let path = "/bin"
        let configuration = NSWorkspace.OpenConfiguration()
        configuration.arguments = [path]
        NSWorkspace.shared.openApplication(at: url,
                                           configuration: configuration,
                                           completionHandler: nil)
    } // https://stackoverflow.com/questions/27505022/open-another-mac-app
    
    func runAppByPath(appPath: String) {
        let url = NSURL(fileURLWithPath: appPath, isDirectory: true) as URL

        let path = "/bin"
        let configuration = NSWorkspace.OpenConfiguration()
        configuration.arguments = [path]
        NSWorkspace.shared.openApplication(at: url,
                                           configuration: configuration,
                                           completionHandler: nil)
    }
}

#if DEBUG
struct ESD_Previews: PreviewProvider {
    static var previews: some View {
        GameESD_View(isFromSidebar: true)
        // digitalArtsFestivalWebView()
    }
}
#endif
