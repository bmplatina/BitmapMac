//
//  SoftwareDistributionView.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/18.
//

import Foundation
import SwiftUI

struct GameESD_View: View {
    var gameTitleForNavigation: String = "Games"
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("7월 20일 (수)").foregroundColor(.gray).bold().font(Font.footnote)
                        Text("Today").font(Font.largeTitle).bold()
                    }
                    Spacer()
                }.padding([.leading, .trailing, .top])
                GameListView().frame(height: 550, alignment: .leading)
            }
        }
        .navigationTitle(gameTitleForNavigation.localized())
    }
}

struct GameListView: View {
    var body: some View {
        VStack {
            ZStack {
                Image("TheHumanity").resizable().scaledToFit()
                LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom).scaledToFit()
                VStack(alignment: .leading) {
                    Spacer()
                    Text("The Humanity").foregroundColor(.white).font(Font.largeTitle).bold()
                    Text("개발: 입학했더니 무한 팀플과 과제가 쌓여버린 건에 대하여\n유통: Bitmap Production").foregroundColor(.white)
                }.padding()
            }
        }.cornerRadius(24).padding().shadow(radius: 4)
    }
}

struct GameDetailsView: View {
    var body: some View {
        Text("OX")
    }
}
#if DEBUG
struct ESD_Previews: PreviewProvider {
    static var previews: some View {
        GameESD_View()
    }
}
#endif
