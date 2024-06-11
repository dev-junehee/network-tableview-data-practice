//
//  BookViewController.swift
//  network-upgrade
//
//  Created by junehee on 6/10/24.
//

import UIKit

import Alamofire
import Kingfisher
import SnapKit


class BookViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var bookList = KakaoBook(documents: [], meta: KakaoBookMeta(is_end: false, pageable_count: 0, total_count: 0))
    
    var page = 1
    var isEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
        configureUI()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        
        searchBar.delegate = self

        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.id)
        tableView.prefetchDataSource = self
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        tableView.backgroundColor = .lightGray
    }


}


extension BookViewController {
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
    
    func callKakaoBookSearch(query: String) {
        let URL = "\(API.URL.kakaoBook)\(query)&page=\(page)&size=10"
        
        let headers: HTTPHeaders = [
            "Authorization": API.KEY.kakaoAuth
        ]
        
        AF.request(URL, headers: headers)
            .responseDecodable(of: KakaoBook.self) { res in
                switch res.result {
                case .success(let value):
                    print("성공")
                    
                    self.isEnd = value.meta.is_end
                    
                    if self.page == 1 {
                        self.bookList.documents = value.documents
                    } else {
                        self.bookList.documents.append(contentsOf: value.documents)
                    }
                    
                    self.tableView.reloadData()
                    
                    if self.page == 1 {
                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                    
                case .failure(let error):
                    print("실패")
                    print(error)
                }
            }
    }
}


// SearchBar 익스텐션
extension BookViewController: UISearchBarDelegate {
    
    // 매번 통신이 들어가지 않고,
    // 빈칸, 최소 1글자 이상, 같은 글자 등에 대한 처리가 필요할 수 있다.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        page = 1
        // 페이지가 1일 때 = 새로운 검색어일 때니까
        // 지금 위치에서 배열을 초기화해줘도 됨! -> 초기화 할거라면 AF 코드 안에서 scrollToRow 안 해줘도 됨
//        bookList.documents.removeAll()
        callKakaoBookSearch(query: searchBar.text!)
    }
}

// Prefetching 익스텐션
extension BookViewController: UITableViewDataSourcePrefetching {
    // cellForRowAt이 호출되기 전에 미리 호출된다.
    // 즉 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운받는 기능
    // 호출 시점은 애플이 알아서 결정한다.
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("Prefetch", indexPaths)
        
        for indexPath in indexPaths {
            if bookList.documents.count - 2 == indexPath.row && !isEnd {
                page += 1
                callKakaoBookSearch(query: searchBar.text!)
            }
        }
    }
    
    // 준비된 로드 취소: 취소 기능은 직접 구현해야 한다.
    // 뷰를 빠르게 스크롤 할 때 중간에 로드하지 않아도 되는 부분들...
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("Cancel Prefetch", indexPaths)
    }
    
    
}

// TableView 익스텐션
extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.id, for: indexPath) as! BookTableViewCell
        
        let data = bookList.documents[indexPath.row]
        
        cell.titleLabel.text = data.title
        cell.overviewLabel.text = data.contents
        cell.thumbnailImageView.kf.setImage(with: URL(string: data.thumbnail))
        
        return cell
    }
}


