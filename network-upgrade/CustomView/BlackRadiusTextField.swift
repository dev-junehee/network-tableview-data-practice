//
//  BlackRadiusTextField.swift
//  network-upgrade
//
//  Created by junehee on 6/12/24.
//

import UIKit

class BlackRadiusTextField: UITextField {

    // 슈퍼클래스에 구현된 init (상속이 되어서 온 친구)
    // 코드베이스로 코드를 구성할 때 호출되는 초기화 구문
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = .boldSystemFont(ofSize: 15)
        textColor = .brown
        textAlignment = .center
        keyboardType = .default
        backgroundColor = .blue
    }
    
    // 스토리보드로 구성할 때 호출되는 초기화 구문 (프로토콜에서 온 친구)
    // 실패 가능한 이니셜라이저 (Failable Initializer)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
