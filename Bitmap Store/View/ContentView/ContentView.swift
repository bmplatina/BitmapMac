//
//  ContentView.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/13.
//

import SwiftUI
import URLImage

let bitmapHomeFolder = "/Users/Shared/Bitmap Production"
let bitmapGameFolder = bitmapHomeFolder + "/Games"

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme // Detect dark mode
    @State var searchFieldText: String = ""
    
    init() {
        do {
            try FileManager.default.createDirectory(atPath: bitmapHomeFolder, withIntermediateDirectories: true, attributes: nil)
            try FileManager.default.createDirectory(atPath: bitmapGameFolder, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        ScrollView {
            HStack(alignment: .center) {
                URLImage(URL(string: "http://www.prodbybitmap.com/w/images/8/86/BitmapWeb.png")!) { image in
                    image
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width:1024)
                        .foregroundColor(colorScheme == .dark ? Color.init(hex: "ffffff") : Color.init(hex: "000000"))
                }
            }
            VStack(alignment: .center) {
                TextField("Bitmap".localized() + " " + "Search".localized(), text: $searchFieldText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading) {
                Text("Games".localized())
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                GameESD_View(isFromSidebar: false)
            }
        }
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
