//
//  OtherESD_View.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/20.
//

import Foundation
import SwiftUI

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
struct OtherESD_Previews: PreviewProvider {
    static var previews: some View {
        OtherESD_View()
    }
}
#endif
