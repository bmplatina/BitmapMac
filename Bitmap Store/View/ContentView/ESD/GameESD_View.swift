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
        ScrollView {
            NavigationView {
                LazyVGrid(columns: columnLayout) {
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
                                    // Text("개발: 입학했더니 무한 팀플과 과제가 쌓여버린 건에 대하여\n유통: Bitmap Production")
                                    Text("개발: \(gameInfo.gameDeveloper[index])\n유통: \(gameInfo.gameDistributor[index])")
                                        .foregroundColor(.white)
                                }.padding()
                            }.cornerRadius(24).padding().shadow(radius: 4)
                        }
                    }
                }
            }
        }
    }
}

/* struct GameListView: View {
    var body: some View {
        HStack {
            ZStack {
                Image("TheHumanity")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 256)
                LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom).frame(width:256, height: 362)
                VStack(alignment: .leading) {
                    // Spacer()
                    Text("The Humanity")
                        .foregroundColor(.white)
                        .font(Font.largeTitle)
                        .bold()
                    // Text("개발: 입학했더니 무한 팀플과 과제가 쌓여버린 건에 대하여\n유통: Bitmap Production")
                    Text("개발: Platina\n유통: Bitmap Production")
                        .foregroundColor(.white)
                }.padding()
            }.cornerRadius(24).padding().shadow(radius: 4)
            // Spacer()
            ZStack {
                Image("OX")
                    .resizable()
                    .scaledToFit()
                    .frame(width:256)
                LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom).frame(width: 256, height: 362)
                VStack(alignment: .leading) {
                    // Spacer()
                    Text("OX")
                        .foregroundColor(.white)
                        .font(Font.largeTitle)
                        .bold()
                    Text("개발: Team. Assertive\n유통: Bitmap Production")
                        .foregroundColor(.white)
                }.padding()
            }.cornerRadius(24).padding().shadow(radius: 4)
        }
    }
} */

struct GameDetailsView: View {
    @State private var installAlert = false
    var gameIndex: Int? = nil
    var body: some View {
        if gameIndex == 0 {
            Image("TheHumanity")
                .resizable()
                .scaledToFit()
                .frame(width: 256)
            
        }
        else if gameIndex == 1 {
            Image("OX")
                .resizable()
                .scaledToFit()
                .frame(width: 256)
        }
        Menu("Install Option".localized()) {
            Button("Install") {
                // installAlert = true
            }
            Button("Update") {
                print("sex")
            }
            Button("Uninstall") {
                print("sex")
            }
        }
    }
}
#if DEBUG
struct ESD_Previews: PreviewProvider {
    static var previews: some View {
        GameESD_View()
    }
}
#endif
