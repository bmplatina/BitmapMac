//
//  ContentView.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/13.
//

import SwiftUI
import WebKit
import Combine

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    } // myLabel.text = "Hello".localized()
    func localized(with argument: CVarArg = [], comment: String = "") -> String {
            return String(format: self.localized(comment: comment), argument)
    } // myLabel.text = "My Age %d".localized(with: 26, comment: "age")
} // https://babbab2.tistory.com/59

struct WebView: NSViewRepresentable {
    let url: URL

    func makeNSView(context: NSViewRepresentableContext<WebView>) -> WKWebView {
        let webView: WKWebView = WKWebView()
        let request = URLRequest(url: self.url)
        webView.customUserAgent = "Safari/605"
        webView.load(request)
        return webView
    }
    func updateNSView(_ webView: WKWebView, context: NSViewRepresentableContext<WebView>) {}
} // https://anpigon.tistory.com/132

struct ContentView: View {
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
