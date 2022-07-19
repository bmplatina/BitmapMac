//
//  SoftwareDistributionView.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/18.
//

import Foundation
import SwiftUI

struct ProjectFilesView: View {
    let url: String = "http://prodbybitmap.com/commission/blog"
    var body: some View {
        GeometryReader { g in
            ScrollView {
                WebView(url: URL(string: url)!)
                    .frame(height: g.size.height)
            }.frame(height: g.size.height)
        }
        .navigationTitle("Blog".localized())
    }
}

struct GameESD_View: View {
    var body: some View {
        Text("sex")
    }
}

struct OtherESD_View: View {
    let url: String = "http://prodbybitmap.com/commission/blog"
    var body: some View {
        GeometryReader { g in
            ScrollView {
                WebView(url: URL(string: url)!)
                    .frame(height: g.size.height)
            }.frame(height: g.size.height)
        }
        .navigationTitle("Blog".localized())
    }
}

#if DEBUG
struct ESD_Previews: PreviewProvider {
    static var previews: some View {
        GameESD_View()
    }
}
#endif
