//
//  DataModelJSON.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/18.
//

import Foundation

// Login Token Data Model
struct loginToken: Codable {
    var csrftoken: String?
}

// Game Info Data Model
struct GameInfo: Codable {
    var Title: String?
    var Platform: String?
    var Engine: String?
    var Genre: String?
    var Developer: String?
    var Publisher: String?
    var isEarlyAccess: Bool = false
    var Released: Int?
    var Website: String = "http://www.prodbybitmap.com/"
    var ImageURL: String = "http://www.prodbybitmap.com/w/images/7/7e/unknownImageA4.png"
}

// Game Info Data Fetcher
// "http://prodbybitmap.com/w/api.php?action=query&meta=tokens&format=json")
