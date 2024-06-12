//
//  Constant.swift
//  network-upgrade
//
//  Created by junehee on 6/12/24.
//

import UIKit

/**
 case + rawValue : Int, String의 리터럴 값만 가능
 static let : UIFont 등의 UIKit 사용 가능
 static이 붙는 이유는 enum은 인스턴스화가 불가능하기 때문에 enum 자체에 접근해서 사용해야 하기 때문
 
 중첩된 열거형 - Nested Enum
 
 */

enum Constant {
    enum Color {
        static let bg = UIColor.systemBackground
        static let text = UIColor.black
        
    }
    
    enum Font {
        static let bold15 = UIFont.boldSystemFont(ofSize: 16)
    }

    enum Spacing: Int {
        case horizontal = 24     // leading, trailing
        case button = 8
        case fieldHeight = 22
    }

    enum Button {
        static let alertOK = "확인"
        static let signOK = "확인"
    }

    enum Radius: Int {
        case imageView = 8
        case textField = 10
        case cell = 12
    }
    
    enum Test: String {
        case width, height, top, bttom = "10"
    }

    enum Field {
        static let nickname = "닉네임이에요"
        static let email = "이메일이에요"
        static let password = "비밀번호에요"
    }
}

