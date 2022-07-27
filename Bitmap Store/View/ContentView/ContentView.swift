//
//  ContentView.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/13.
//

import SwiftUI
import URLImage

struct ContentView: View {
    var body: some View {
        ScrollView {
            HStack(alignment: .center) {
                URLImage(URL(string: "http://www.prodbybitmap.com/w/images/8/86/BitmapWeb.png")!) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width:1024)
                }
            }
            VStack(alignment: .leading) {
                Text("Games".localized())
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                GameESD_View(isFromSidebar: false)
            }
        }
        .navigationTitle("Home".localized())
    }
}

struct WebsiteView: View {
    var url: String
    var viewTitle: String
    var body: some View {
        GeometryReader { g in
            ScrollView {
                WebView(url: URL(string: url)!)
                    .frame(height: g.size.height)
            }.frame(height: g.size.height)
        }
        .navigationTitle(viewTitle.localized())
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
