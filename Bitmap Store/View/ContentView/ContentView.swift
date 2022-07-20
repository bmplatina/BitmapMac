//
//  ContentView.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/13.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var wikiToken: loginToken?
    let url: String = "http://prodbybitmap.com"
    
    var body: some View {
        GeometryReader { g in
            ScrollView {
                WebView(url: URL(string: url)!)
                    .frame(height: g.size.height)
            }.frame(height: g.size.height)
        }
        .navigationTitle("Bitmap".localized())
    }
}

struct BitmapWikiView: View {
    let url: String = "http://prodbybitmap.com/"
    var body: some View {
        GeometryReader { g in
            ScrollView {
                WebView(url: URL(string: url)!)
                    .frame(height: g.size.height)
            }.frame(height: g.size.height)
        }
        .navigationTitle("Newsroom".localized())
    }
}

struct NewsroomView: View {
    let url: String = "http://prodbybitmap.com/commission/bitmap_notices"
    var body: some View {
        GeometryReader { g in
            ScrollView {
                WebView(url: URL(string: url)!)
                    .frame(height: g.size.height)
            }.frame(height: g.size.height)
        }
        .navigationTitle("Newsroom".localized())
    }
}

struct BlogView: View {
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

struct SettingsView: View {
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
