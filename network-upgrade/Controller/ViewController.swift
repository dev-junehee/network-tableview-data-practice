//
//  ViewController.swift
//  network-upgrade
//
//  Created by junehee on 6/5/24.
//

import UIKit

import Alamofire
import SnapKit

struct Lotto: Decodable {
    let returnValue: String
    let drwNoDate: String
    let totSellamnt: Int
//    let firstWinamnt: Int
//    let firstPrzwnerCo: Int
//    let firstAccumamnt: Int
//    let drwNo: Int
//    let drwtNo1: Int
//    let drwtNo2: Int
//    let drwtNo3: Int
//    let drwtNo4: Int
//    let drwtNo5: Int
//    let drwtNo6: Int
//    let bnusNo: Int
}

class ViewController: UIViewController {
    
    let numberField = UITextField()
    let checkButton = UIButton()
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy() {
        let subviews = [numberField, checkButton, resultLabel]
        
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    func configureLayout() {
        numberField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)  // 탑 왼 오 20씩
            make.height.equalTo(50)
        }
        
        checkButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)  // 정중앙
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(checkButton.snp.bottom).offset(20)
            make.size.equalTo(300)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        numberField.backgroundColor = .gray
        resultLabel.backgroundColor = .systemPink
        resultLabel.numberOfLines = 0
        checkButton.backgroundColor = .blue
        checkButton.setTitle("로또 당첨 번호 확인", for: .normal)
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func checkButtonClicked() {
        LottoManager.shared.callRequest(number: numberField.text ?? "1") { number in
            self.resultLabel.text = number
        }
    }

}

