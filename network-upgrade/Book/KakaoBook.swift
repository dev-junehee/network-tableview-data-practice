//
//  KakaoBook.swift
//  network-upgrade
//
//  Created by junehee on 6/11/24.
//

import Foundation

struct KakaoBook: Decodable {
    // 데이터 통신 결과(페이지네이션)로 추가 데이터를 append 해줘야하기 때문에 var로 수정
    var documents: [KaKaoBookDocuments]
    let meta: KakaoBookMeta
}

struct KaKaoBookDocuments: Decodable {
    let title: String
    let contents: String
    let authors: [String]
    let publisher: String
    let datetime: String
    let isbn: String
    let price: Int
    let sale_price: Int
    let status: String
    let translators: [String]
    let thumbnail: String
    let url: String
}

struct KakaoBookMeta: Decodable {
    let is_end: Bool
    let pageable_count: Int
    let total_count: Int
}
