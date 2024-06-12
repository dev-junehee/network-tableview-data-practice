//
//  SignViewController.swift
//  network-upgrade
//
//  Created by junehee on 6/12/24.
//

import UIKit
import SnapKit

class SignViewController: UIViewController {
    
    lazy var nicknameField = {
        let view = BlackRadiusTextField()
        view.placeholder = Constant.Field.nickname
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(nicknameField)
        
        nicknameField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(30)
        }
    }
    

}
