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
//
//class MarketViewController: UIViewController {
//    
//    let marketTableView = UITableView()
//    
//    var marketList: [Market] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        configureTableView()
//        
//        print(#function, "11111")
//        callRequest()
//        print(#function, "22222")
//    }
//    
//    func configureTableView() {
//        view.backgroundColor = .systemBackground
//        view.addSubview(marketTableView)
//
//        marketTableView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//        marketTableView.backgroundColor = .systemGray5
//        
//        marketTableView.delegate = self
//        marketTableView.dataSource = self
//        
//        marketTableView.rowHeight = 60
//        
//        marketTableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.identifier)
//    }
//    
//    func callRequest() {
//        print(#function, "33333")
//        let URL = "https://api.upbit.com/v1/market/all"
//
//        AF.request(URL).responseDecodable(of: [Market].self) { res in
//            switch res.result {
//            case .success(let value):
//                print("성공!")
//                self.marketList = value
//                self.marketTableView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
//        print(#function, "44444")
//    }
//    
//}
//
//
//extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(#function, marketList.count)
//        return marketList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = marketTableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as! MarketTableViewCell
//        let idx = indexPath.row
//        
//        cell.nameLabel.text = marketList[idx].market
//        
//        return cell
//    }
//
//}
