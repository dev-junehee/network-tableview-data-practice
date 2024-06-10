//
//  BookViewController.swift
//  network-upgrade
//
//  Created by junehee on 6/10/24.
//

import UIKit
import Alamofire

class BookViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        callRequest()
//        callRequestKoGPT()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    
    /**
     1. URL
     2. Query String
     3. HTTP Header - 조건 맞게 해주기  (Authorization)
     3. Request
     4. Response
     - responseSerializationFailed 오류 나면 responseString으로 확인하기
     - 바꿔주려는 Struct 구조체 확인하기
     5. HTTP Status Code
     */
    func callRequest() {
        print(#function)
        
        let query = ""
        let display = 20
        let start = 1
        
        let BOOK_URL = "\(API.URL.book)query=\(query)&display=\(display)&start=\(start)"
        
        let header: HTTPHeaders = [
            API.KEY_NAME.naverId: API.KEY.naverId,
            API.KEY_NAME.naverSecret: API.KEY.naverSecret,
        ]
        
        AF.request(BOOK_URL,
                    method: .get,
                    headers: header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: Book.self) { res in
            print(res.response?.statusCode ?? 0)
            switch res.result {
            case .success(let value):
                print("성공")
                print(value)
            case .failure(let error):
                print("실패")
                print(error)
            }
        }
    }
    
    func callRequestKoGPT() {
        print(#function)
        
        let header: HTTPHeaders = [
            "Authorization": API.KEY.kakaoAuth,
            "Content-Type": "application/json"
        ]
        
        let param: Parameters = [
            "prompt": "점심 메뉴 추천해줘~",
            "max_tokens": 50
        ]
        
        AF.request(API.URL.koGPT, 
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseDecodable(of: Book.self) { res in
            switch res.result {
            case .success(let value):
                print("성공")
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
