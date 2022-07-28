//
//  SoftwareDistributionView.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/18.
//

import Foundation
import SwiftUI
import URLImage

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
            .navigationTitle("Games".localized())
        }
    }
}

struct GameButtons: View {
    @State private var showingPopover = false
    @State private var installAlert = false
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
                    Text(gameInfos.gameTitle)
                        .foregroundColor(.white)
                        .font(Font.largeTitle)
                        .bold()
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
                    VStack(alignment: .leading) {
                        Text("Bitmap Games")
                            .font(Font.largeTitle)
                            .bold()
                        Text("Bitmap Store".localized())
                    }
                    
                    Spacer()
                    Button(action: { showingPopover = false }) {
                        Image(systemName: "x.circle")
                            .font(.title2)
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
                // GameDetailsView(gameInfos: )
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
                                       .padding(.top)
                               }
                           }.padding(.leading)
                           Text("Released on: ".localized() + ": " + String(gameInfos.gameReleasedDate))
                               .padding(.leading)
                           Text("Genre".localized() + ": " + gameInfos.gameGenre)
                               .padding(.leading)
                           Text("Developer".localized() + ": " + gameInfos.gameDeveloper)
                               .padding(.leading)
                           Text("Publisher".localized() + ": " + gameInfos.gamePublisher)
                               .padding(.leading)
                           Divider()
                               .padding()
                           ScrollView {
                               Text(gameInfos.gameHeadline)
                                   .font(Font.largeTitle)
                                   .bold()
                                   .padding()
                               Text(gameInfos.gameDescription)
                           }.padding()
                       }
                   }
                   
                   Spacer()
                   
                   switch true {
                   case true:
                       HStack {
                           Button(action: {
                               // runCommand(command: "open " +  gameInfos.gameInstallationPathMac)
                           }) {
                               Text("Play".localized())
                                   .font(.title3)
                           }
                           .padding()
                           .buttonStyle(GrowingButton())
                           Button(action: {
                               // runCommand(command: "rm -rf " +  gameInfos.gameInstallationPathMac)
                           }) {
                               Text("Uninstall".localized())
                                   .font(.title3)
                           }
                           .padding()
                           .buttonStyle(GrowingButton())
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
            }
            .frame(width: 1000, height: 600)
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
}

#if DEBUG
struct ESD_Previews: PreviewProvider {
    static var previews: some View {
        GameESD_View(isFromSidebar: true)
        // digitalArtsFestivalWebView()
    }
}
#endif
