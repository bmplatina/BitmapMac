//
//  Extensions.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/21.
//

import Foundation
import SwiftUI
import WebKit

let bundlePath = Bundle.main.bundlePath
let applicationSupportPath = NSHomeDirectory()

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    } // myLabel.text = "Hello".localized()
    func localized(with argument: CVarArg = [], comment: String = "") -> String {
            return String(format: self.localized(comment: comment), argument)
    } // myLabel.text = "My Age %d".localized(with: 26, comment: "age")
    // Above about localized: https://babbab2.tistory.com/59
    // Automatically convert English strings to Korean
}

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationTitle("")
                    .hidden()

                NavigationLink(
                    destination: view
                        .navigationTitle("")
                        .hidden(),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
    } // https://stackoverflow.com/questions/56437335/go-to-a-new-view-using-swiftui
}

extension URLSession {
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws  -> T {
        let (data, _) = try await data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy

        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }   // https://www.hackingwithswift.com/quick-start/concurrency/how-to-download-json-from-the-internet-and-decode-it-into-any-codable-type
}

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

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
} // https://www.hackingwithswift.com/quick-start/swiftui/customizing-button-with-buttonstyle
