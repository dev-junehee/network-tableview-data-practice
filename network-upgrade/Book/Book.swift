//
//  Book.swift
//  network-upgrade
//
//  Created by junehee on 6/10/24.
//

import Foundation

struct Book: Decodable {
    let total: Int
    let start: Int
    let display: Int
    let items: [BookItem]
}

struct BookItem: Decodable {
    let title: String
    let link: String
    let image: String
    let author: String
    let pubdate: String
    let description: String
}
