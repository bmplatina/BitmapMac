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
    @State private var showingPopover = false
    @State private var showingDigitalArtsFestivalSheet = false
    @State private var searchField: String = ""
    @StateObject var apiClient = gameApiClient()
    
    let columnLayout = Array(repeating: GridItem(), count: 4)
    let gameInfo: exampleGameInfo = exampleGameInfo()
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.init(hex: "4188F1"))
                    .frame(height: 42)
                    .shadow(radius: 4)
                HStack {
                    Spacer()
                    Image("bitmapWebLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                    Spacer()
                    if true {
                        Text("Online")
                    }
                    else {
                        Text("Offline Mode")
                    }
                    TextField("Filter".localized(), text: $searchField)
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
                    LazyVGrid(columns: columnLayout, alignment: .center, spacing: 2) {
                        ForEach(0..<gameInfo.gameIndex+1, id:\.self) { index in
                            Button {
                                showingPopover = true
                            } label: {
                                ZStack {
//                                    Image("unknownImage")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 300)
                                    URLImage(URL(string: gameInfo.gamePosterURL[index])!) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:300)
                                    }
                                    LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom).frame(width: 300, height: 424)
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        Text(gameInfo.gameTitle[index])
                                            .foregroundColor(.white)
                                            .font(Font.largeTitle)
                                            .bold()
                                        Divider()
                                        Text("Dev".localized() + ": " + gameInfo.gameDeveloper[index])
                                            .foregroundColor(.white)
                                    }
                                    .frame(width:256)
                                    .padding()
                                }
                                .cornerRadius(24)
                                .shadow(radius: 4)
                                .padding()
                            }
                            .buttonStyle(PlainButtonStyle())
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
                                    GameDetailsView(gameIndex: index)
                                }
                                .frame(width: 1000, height: 600)
                                .fixedSize()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Games".localized())
            .onAppear {
                apiClient.loadGameInfo()
            }
        }
    }
}

struct GameDetailsView: View {
    @State private var installAlert = false
    
    let gameInfo: exampleGameInfo = exampleGameInfo()
    var gameIndex: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack {
                    Image("unknownImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 256)
                        .cornerRadius(24)
                        .shadow(radius: 4)
                        .padding()
                    URLImage(URL(string: gameInfo.gamePosterURL[gameIndex])!) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 256)
                            .cornerRadius(24)
                            .padding()
                    }
                }
                Divider()
                VStack(alignment: .leading) {
                    Text(gameInfo.gameTitle[gameIndex])
                        .font(Font.largeTitle)
                        .bold()
                        .padding(.leading)
                    Text("Developer".localized() + ": " + gameInfo.gameDeveloper[gameIndex])
                        .padding(.leading)
                    Text("Publisher".localized() + ": " + gameInfo.gameDistributor[gameIndex])
                        .padding(.leading)
                    Divider()
                        .padding()
                    ScrollView {
                        Text(gameInfo.gameHeadline[gameIndex])
                            .font(Font.largeTitle)
                            .bold()
                            .padding()
                        Text(gameInfo.gameDescription[gameIndex])
                    }.padding()
                }
            }
            
            Spacer()
            
            switch gameInfo.isInstalled[gameIndex] {
            case true:
                HStack {
                    Button(action: { }) {
                        Text("Play".localized())
                            .font(.title3)
                    }
                    .padding()
                    .buttonStyle(GrowingButton())
                    Button(action: { }) {
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
                    Alert(title: Text(gameInfo.gameTitle[gameIndex] + " will be installed".localized()), message: Text("Bitmap Store couldn't reach to server. Please check your internet connection.".localized()), dismissButton: .default(Text("Dismiss")))
                }
                .padding()
                .buttonStyle(GrowingButton())
            }
        }
        .onAppear {
        }
    }
}

struct digitalArtsFestivalWebView: View {
    var body: some View {
        GeometryReader { g in
            ScrollView {
                WebView(url: URL(string: "https://siadigitalart.com/2022")!)
                    .frame(height: g.size.height)
            }.frame(height: g.size.height)
        }
    }
}

#if DEBUG
struct ESD_Previews: PreviewProvider {
    static var previews: some View {
        GameESD_View()
        // digitalArtsFestivalWebView()
    }
}
#endif
