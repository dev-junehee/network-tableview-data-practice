//
//  MarketViewController.swift
//  network-upgrade
//
//  Created by junehee on 6/5/24.
//

import UIKit

import Alamofire
import SnapKit

struct Market: Decodable {
    let market: String
    let korean_name: String
    let english_name: String
}

class MarketViewController: UIViewController {
    
    let marketTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        
        print(#function, "11111")
//        callRequest()
        print(#function, "22222")
    }
    
    func configureTableView() {
        view.addSubview(marketTableView)

        marketTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        marketTableView.backgroundColor = .systemGray5
        
        marketTableView.delegate = self
        marketTableView.dataSource = self
        
        
    }
    
    func callRequest() {
        print(#function, "33333")
        let URL = "https://api.upbit.com/v1/market/all"

        AF.request(URL).responseDecodable(of: [Market].self) { res in
            switch res.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
        print(#function, "44444")
    }
    
}


extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}
