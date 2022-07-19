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
                    NavigationLink(destination: ContentView()) {
                        Label("Home".localized(), systemImage: "house")
                    }
                    NavigationLink(destination: BitmapWikiView()) {
                        Label("Wiki".localized(), systemImage: "book")
                    }
                    NavigationLink(destination: NewsroomView()) {
                        Label("Newsroom".localized(), systemImage: "newspaper")
                    }
                    NavigationLink(destination: BlogView()) {
                        Label("Blog".localized(), systemImage: "message")
                    }
                }
                // 공간
                Spacer()
                Text("Bitmap Store".localized())
                
                NavigationLink(destination: ProjectFilesView()) {
                    Label("Project Files".localized(), systemImage: "folder")
                }
                NavigationLink(destination: GameESD_View()) {
                    Label("Games".localized(), systemImage: "gamecontroller")
                }
                NavigationLink(destination: OtherESD_View()) {
                    Label("Other Downloads".localized(), systemImage: "square.and.arrow.down.on.square")
                }
                
                Spacer()
                Divider()
                NavigationLink(destination: SettingsView()) {
                    Label("Settings".localized(), systemImage: "gear")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Bitmap".localized())
            // 사이드바 폭과 높이 최솟값
            .frame(minWidth: 150, idealWidth: 250, maxWidth: 300)
            .toolbar{
                //Toggle Sidebar Button
                ToolbarItem(placement: .navigation){
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.left")
                    })
                }
            }
            #if DEBUG
            ContentView()
            #endif
        }
    }
}

// Toggle Sidebar Function
func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
