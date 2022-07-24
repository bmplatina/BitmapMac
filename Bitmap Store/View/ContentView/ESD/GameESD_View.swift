//
//  SoftwareDistributionView.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/18.
//

import Foundation
import SwiftUI

struct GameESD_View: View {
    let columnLayout = Array(repeating: GridItem(), count: 3)
    var gameInfo: exampleGameInfo = exampleGameInfo()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack /* LazyVGrid(columns: columnLayout, alignment: .center, spacing: 16) */ {
                    ForEach(0..<gameInfo.gameIndex+1, id:\.self) { index in
                        NavigationLink(destination: GameDetailsView(gameIndex: index)) {
                            ZStack {
                                Image(gameInfo.gameImage[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 256)
                                LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom).frame(width:256, height: 362)
                                VStack(alignment: .leading) {
                                    // Spacer()
                                    Text(gameInfo.gameTitle[index])
                                        .foregroundColor(.white)
                                        .font(Font.largeTitle)
                                        .bold()
                                    Text(gameInfo.gameDeveloper[index])
                                        .foregroundColor(.white)
                                }
                                .padding()
                            }
                            .cornerRadius(24)
                            .shadow(radius: 4)
                            .padding()
                        }
                    }
                }
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Games".localized())
    }
}

struct GameDetailsView: View {
    let gameInfo: exampleGameInfo = exampleGameInfo()
    @State private var installAlert = false
    var gameIndex: Int
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(gameInfo.gameImage[gameIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 256)
                    .padding()
                VStack(alignment: .leading) {
                    Text(gameInfo.gameTitle[gameIndex])
                        .font(Font.largeTitle)
                        .bold()
                    Text("Developer".localized() + ": " + gameInfo.gameDeveloper[gameIndex])
                    Text("Distributor".localized() + ": " + gameInfo.gameDistributor[gameIndex])
                }.padding()
                
                Divider()
                ScrollView {
                    VStack(alignment: .leading) {
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
                Button("Uninstall".localized()) {
                    
                }
                .padding()
            case false:
                Button("Install".localized()) {
                    
                }
                .padding()
            }
        }
        .navigationTitle(gameInfo.gameTitle[gameIndex])
    }
}
#if DEBUG
struct ESD_Previews: PreviewProvider {
    static var previews: some View {
        GameESD_View()
    }
}
#endif
