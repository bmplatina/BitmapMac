//
//  Sidebar.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/14.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        NavigationView {
            List {
                Text("Bitmap".localized())    // 캡션
                Group {
//                    NavigationLink(destination: ContentView()) {
//                        Label("Home".localized(), systemImage: "house")
//                    }
                    NavigationLink(destination: WebsiteView(url: "http://prodbybitmap.com", viewTitle: "Wiki")) {
                        Label("Wiki".localized(), systemImage: "book")
                    }
                    NavigationLink(destination: WebsiteView(url: "http://prodbybitmap.com/commission/bitmap_notices/", viewTitle: "Newsroom")) {
                        Label("Newsroom".localized(), systemImage: "newspaper")
                    }
                    NavigationLink(destination: WebsiteView(url: "http://prodbybitmap.com/commission/blog", viewTitle: "Blog")) {
                        Label("Blog".localized(), systemImage: "message")
                    }
                }
                Spacer()
                Text("Bitmap Store".localized())
                
                NavigationLink(destination: WebsiteView(url: "http://prodbybitmap.com/commission/blog", viewTitle: "Project Files")) {
                    Label("Project Files".localized(), systemImage: "folder")
                }
                NavigationLink(destination: GameESD_View(isFromSidebar: true)) {
                    Label("Games".localized(), systemImage: "gamecontroller")
                }
                NavigationLink(destination: OtherESD_View()) {
                    Label("Other Downloads".localized(), systemImage: "square.and.arrow.down.on.square")
                }
                
                Spacer()
                Divider()
                NavigationLink(destination: WebsiteView(url: "http://www.prodbybitmap.com/wiki/Special:Login", viewTitle: "Settings")) {
                    Label("Settings".localized(), systemImage: "gear")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Bitmap".localized())
            // 사이드바 폭과 높이 최솟값
            .frame(minWidth: 150, idealWidth: 250, maxWidth: 300)
            .toolbar {
                //Toggle Sidebar Button
                ToolbarItem(placement: .navigation){
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.left")
                    })
                }
            }
            .touchBar {
                Text("Bitmap Powered by Platina")
            }
            #if os(macOS)
            ContentView()
            #endif
        }
    }
}

// Toggle Sidebar Function
#if os(macOS)
func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}
#endif

#if DEBUG
struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
#endif
