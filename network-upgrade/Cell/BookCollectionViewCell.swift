//
//  BookCollectionViewCell.swift
//  network-upgrade
//
//  Created by junehee on 6/11/24.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let id = "BookCollectionViewCell"
    
    // 테이블뷰와 달리 커렉션뷰는 시시ㅡ템 디자인이 없어서 파라미터가 다름
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
