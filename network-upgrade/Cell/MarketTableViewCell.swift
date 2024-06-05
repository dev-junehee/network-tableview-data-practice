//
//  MarketTableViewCell.swift
//  network-upgrade
//
//  Created by junehee on 6/5/24.
//

import UIKit
import SnapKit

class MarketTableViewCell: UITableViewCell {
    
    static let identifier = "MarketTableViewCell"
    let nameLabel = UILabel()

    // NIB == XIB >>> XIB가 없다면 코드 실행이 안 됨 >>> init 함수 사용
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        nameLabel.textColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
