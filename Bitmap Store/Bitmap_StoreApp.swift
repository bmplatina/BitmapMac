//
//  Bitmap_StoreApp.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/13.
//

import SwiftUI
import URLImage
import URLImageStore

@main
struct Bitmap_StoreApp: App {
    var body: some Scene {
        let fileStore = URLImageFileStore()
        let inMemoryStore = URLImageInMemoryStore()
        let urlImageService = URLImageService(fileStore: fileStore, inMemoryStore: inMemoryStore)
        
        return WindowGroup {
            Sidebar()
                .environment(\.urlImageService, urlImageService)
        }
    }
}
