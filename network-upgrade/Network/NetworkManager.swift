//
//  NetworkManager.swift
//  network-upgrade
//
//  Created by junehee on 6/24/24.
//

import Foundation
import Alamofire


class LottoManager {
    
    private init() {}
    
    static let shared = LottoManager()
    
    func callRequest(number: String,
                     completionHandler: @escaping (String) -> Void
    ) {
        let URL = "\(API.URL.lotto)\(number)"

        AF.request(URL).responseDecodable(of: Lotto.self) { res in
            switch res.result {
            case .success(let value):
                print(value)
                
                let result = """
                \(value.drwNoDate)
                1등 당첨 금액: \(value.totSellamnt.formatted())원
                """
                
                completionHandler(result)
                
            case .failure(let error):
                print(error)
                
                completionHandler("올바른 값을 입력해 주세요!")
            }
        }
        
    }
}
