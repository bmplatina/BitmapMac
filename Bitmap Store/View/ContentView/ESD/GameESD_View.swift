//
//  SoftwareDistributionView.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/18.
//

import SwiftUI
import URLImage
import YouTubePlayerKit
import Alamofire
import Zip

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
    @Environment(\.colorScheme) var colorScheme         // Detect dark mode
    @State private var showingPopover = false           // Showing pop-ups for game details view
    @State private var installAlert = false             // Showing Install Wizard
    @State private var uninstallAlert = false           // Showing Uninstall Wizard
    @State private var showProgressBar = false
    @State private var showUnzipProgress = false
    @State private var showUnsupportedPlatformAlert = false
    @State private var progressBarValue: CGFloat = 0.0    // Progress bar value
    @State private var progressBarPercentage = "0%"
    @State private var forceMacSupport = false
    @State private var isInstalling = false
    @State private var isUninstalling = false
    
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
                    Text("Dev".localized() + ": \(gameInfos.gameDeveloper)")
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
                        .fill(colorScheme == .dark ? Color(hex: "625b5b") : Color(hex: "d6d1cd"))
                        .frame(width:12.5)
                        .padding([.bottom, .trailing], 1)
                    Circle()
                        .fill(colorScheme == .dark ? Color(hex: "625b5b") : Color(hex: "d6d1cd"))
                        .frame(width:12.5)
                        .padding([.bottom, .trailing], 1)
                    Spacer()
                    VStack(alignment: .center) {
                        Text("Bitmap Store".localized() + ": \(gameInfos.gameTitle)")
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
                           Text("Released on".localized() + ": \(gameInfos.gameReleasedDate)")
                               .padding(.leading)
                           Text("Genre".localized() + ": \(gameInfos.gameGenre)")
                               .padding(.leading)
                           Text("Developer".localized() + ": \(gameInfos.gameDeveloper)")
                               .padding(.leading)
                           Text("Publisher".localized() + ": \(gameInfos.gamePublisher)")
                               .padding(.leading)
                           Link("Visit game website".localized(), destination: URL(string: gameInfos.gameWebsite)!)
                               .padding(.leading)
                           Divider()
                               .padding()
                           ScrollView {
                               VStack(alignment: .leading) {
                                   Text("Instruction Video".localized())
                                       .font(Font.largeTitle)
                                       .bold()
                                       .padding()
                                   Divider()
                                       .padding(.horizontal)
                                   YouTubePlayerView("https://www.youtube.com/watch?v=WSLxwXMwIog")
                                       .frame(width:200)
                                       .padding()
                               }.padding()
                                .background(Rectangle().fill(colorScheme == .dark ? Color.init(hex: "404040") : Color.init(hex: "dedede")))
                                .cornerRadius(16)
                                .shadow(radius: 4)
                               
                               VStack(alignment: .leading) {
                                   Text(gameInfos.gameHeadline)
                                       .font(Font.largeTitle)
                                       .bold()
                                       .padding()
                                   Divider()
                                       .padding(.horizontal)
                                   Text(gameInfos.gameDescription)
                                       .padding()
                               }.padding()
                                .background(Rectangle().fill(colorScheme == .dark ? Color.init(hex: "404040") : Color.init(hex: "dedede")))
                                .cornerRadius(16)
                                .shadow(radius: 4)
                               VStack(alignment: .leading) {
                                   Text("Requirements".localized())
                                       .font(Font.largeTitle)
                                       .bold()
                                       .padding()
                                   Divider()
                                       .padding(.horizontal)
                                   HStack {
                                       if gameInfos.gamePlatformMac {
                                           Text("Mac\nOS: macOS High Sierra 10.13+\nCPU: AMD64 architecture with SSE2 instruction set support, Apple Silicon\nGPU: Metal-capable Intel and AMD GPUs, Apple Silicon")
                                               .padding()
                                       }
                                       if gameInfos.gamePlatformMac && gameInfos.gamePlatformWindows {
                                           Divider()
                                               .padding()
                                       }
                                       if gameInfos.gamePlatformWindows {
                                           Text("Windows\nOS: Windows 7 (SP1+) and Windows 10, 64-bit versions only.\nCPU: AMD64 architecture with SSE2 instruction set support\nGPU: DX10, DX11, and DX12-capable GPUs")
                                               .padding()
                                       }
                                   }
                               }.padding()
                                .background(Rectangle().fill(colorScheme == .dark ? Color.init(hex: "404040") : Color.init(hex: "dedede")))
                                .cornerRadius(16)
                                .shadow(radius: 4)
                           }.padding(.horizontal)
                       }
                   }
                   
                   Spacer()
                    
                   if gameInfos.gamePlatformMac || forceMacSupport {
                       switch isInstalling {
                       case true:
                           HStack {
                               Button(action: {
                                   if gameInfos.gamePlatformMac {
                                       runAppByPath(appPath: "\"\(bitmapGameFolder)/\(gameInfos.gameBinaryName)/\(gameInfos.gameBinaryName).app\"")
                                   }
                                   else {
                                       runCommand(command: "open \"\(bitmapGameFolder)/\(gameInfos.gameBinaryName)/\(gameInfos.gameBinaryName).exe\"")
                                   }
                               }) {
                                   Text(forceMacSupport ? "Open".localized() : "Play".localized())
                                       .font(.title3)
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
                                            runCommand(command: "rm -rvf \"\(bitmapGameFolder)/\(gameInfos.gameBinaryName)/\"")
                                    }),
                                    secondaryButton: .default(
                                        Text("Cancel".localized())
                                    ))
                               }
                               .padding()
                               .buttonStyle(GrowingButton())
                               if showProgressBar {
                                   ProgressView(showUnzipProgress ? "Writing to Disk".localized() : "Downloading".localized() + ": \(progressBarPercentage)", value: progressBarValue, total: CGFloat(1.0))
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
                               Alert(title: Text(gameInfos.gameTitle + " will be installed".localized()), message: Text("Installation Path".localized() + ": \(bitmapGameFolder)"),
                                     primaryButton: .destructive(
                                         Text("Install".localized()), action: {
                                             do {
                                                 try FileManager.default.createDirectory(atPath: "\(bitmapGameFolder)/\(gameInfos.gameBinaryName)/", withIntermediateDirectories: true, attributes: nil)
                                             } catch {
                                                 print(error)
                                             }
                                             downloadGame(url: gameInfos.gameDownloadMacURL, gameName: gameInfos.gameBinaryName)
                                             showProgressBar = true
                                             isInstalling = true
                                     }),
                                     secondaryButton: .default(
                                         Text("Cancel".localized())
                                     ))
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
    
    func downloadGame(url: String, gameName: String) {
        self.showUnzipProgress = false
        // 파일매니저
        let fileManager = FileManager.default
        // 앱 경로
        let appURL = fileManager.urls(for: .userDirectory, in: .localDomainMask)[0]
        // 파일 경로 생성
        let fileURL = appURL.appendingPathComponent("Shared/Bitmap Production/Games/\(gameName)/\(gameName).zip")
        // 파일 경로 지정 및 다운로드 옵션 설정 ( 이전 파일 삭제 , 디렉토리 생성 )
        let destination: DownloadRequest.Destination = { _, _ in
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        // 다운로드 시작
        AF.download(url, method: .get, parameters: nil, encoding: JSONEncoding.default, to: destination).downloadProgress { (progress) in
            // 이 부분에서 프로그레스 수정
            self.progressBarValue = CGFloat(progress.fractionCompleted)
            self.progressBarPercentage = "\(Int(progress.fractionCompleted * 100))%"
            print("Downloading: \(progress.fractionCompleted)")
        }
        .response { response in
            if response.error != nil {
                print("Download Failed")
            }
            else {
                print("\(gameName) has been Downloaded")
                unzipGame(gameName: gameName)
            }
        }
    }   // https://gonslab.tistory.com/14
    func unzipGame(gameName: String) {
        do {
            self.showUnzipProgress = true
            let gameDirectory = FileManager.default.urls(for:.userDirectory, in: .localDomainMask)[0]
            let zipPath = gameDirectory.appendingPathComponent("Shared/Bitmap Production/Games/\(gameName)/\(gameName).zip")
            let destinationDirectory = gameDirectory.appendingPathComponent("Shared/Bitmap Production/Games/\(gameName)/")
            try Zip.unzipFile(zipPath, destination: destinationDirectory, overwrite: true, password: "", progress: { (progress) -> () in
                self.progressBarValue = CGFloat(progress)
                print("Unzipping: \(progress)")
            }) // Unzip
            self.showUnzipProgress = false
            self.showProgressBar = false

        }
        catch {
            print("Something went wrong")
        }
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
