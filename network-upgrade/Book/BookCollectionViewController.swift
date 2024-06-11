//
//  BookCollectionViewController.swift
//  network-upgrade
//
//  Created by junehee on 6/11/24.
//

import UIKit
import SnapKit

class BookCollectionViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout() // 테이블뷰의 rowHeight와 같음
        
        // itemsize 셀 자체의 크기 (디바이스마다 너비가 다르기 때문에 계산해야함)
        // (디바이스 크기) - (총 여백 크기) / 셀의 개수
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.scrollDirection = .vertical   // 스크롤 방향
        layout.minimumInteritemSpacing = 10    // 셀과 셀 사이 가로 간격
        layout.minimumLineSpacing = 10        // 셀과 셀 사이 세로 간격
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)    // 셀과 뷰 사이 간격
        
        return layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        collectionView.backgroundColor = .darkGray
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.id)
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}


extension BookCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.id, for: indexPath) as! BookCollectionViewCell
        
        return cell
    }
}
