//
//  NasaViewController.swift
//  network-upgrade
//
//  Created by junehee on 7/1/24.
//

import UIKit
import SnapKit

/**
 URLSession Deletate Practice
 */
final class NasaViewController: UIViewController {
    
    enum Nasa: String, CaseIterable {
        static let baseURL = "https://apod.nasa.gov/apod/image/"
        
        case one = "2308/sombrero_spitzer_3000.jpg"
        case two = "2212/NGC1365-CDK24-CDK17.jpg"
        case three = "2307/M64Hubble.jpg"
        case four = "2306/BeyondEarth_Unknown_3000.jpg"
        case five = "2307/NGC6559_Block_1311.jpg"
        case six = "2304/OlympusMons_MarsExpress_6000.jpg"
        case seven = "2305/pia23122c-16.jpg"
        case eight = "2308/SunMonster_Wenz_960.jpg"
        case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
        
        static var photo: URL {
            return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
        }
    }
    
    private let nasaImage = UIImageView()
    private let progressLabel = UILabel()
    private let requestButton = UIButton()
    
    // 데이터 총 크기 / 진행률
    var total: Double = 0
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total * 100
            progressLabel.text = "\(result)%"
        }
    }
    
    var session: URLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureHandler()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 화면 사라질 때 네트워크 통신 중단 (진행 중인 리소스 무시)
        session?.invalidateAndCancel()
        
        // 다운로드 완료 후 리소스 정리
        session?.finishTasksAndInvalidate()
    }
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureHierarchy() {
        let subviews = [nasaImage, progressLabel, requestButton]
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func configureLayout() {
        requestButton.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }

        progressLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(requestButton.snp.bottom).offset(20)
            $0.height.equalTo(50)
        }

        nasaImage.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(progressLabel.snp.bottom).offset(20)
        }
    }
    
    private func configureUI() {
        requestButton.setTitle("버튼", for: .normal)
        requestButton.backgroundColor = .systemMint
        progressLabel.backgroundColor = .systemTeal
        progressLabel.textAlignment = .center
        nasaImage.backgroundColor = .systemCyan
        nasaImage.contentMode = .scaleAspectFill
    }
    
    private func callRequest() {
        let request = URLRequest(url: Nasa.photo)
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session?.dataTask(with: request).resume()
    }
    
    private func configureHandler() {
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    
    @objc func requestButtonClicked() {
        buffer = Data()
        callRequest()
    }
}


extension NasaViewController: URLSessionDataDelegate {
    // 서버 최초 응답
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        guard let res = response as? HTTPURLResponse, (200...299).contains(res.statusCode) else {
            print(#function, "응답 데이터 오류")
            return .cancel
        }
    
        guard let contentLength = res.value(forHTTPHeaderField: "Content-Length") else {
            print(#function, "Content-Length 오류")
            return .cancel
        }
        
        total = Double(contentLength) ?? 0
        return .allow
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(#function, data)
        buffer?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        print(#function, error)
        if let error = error {
            progressLabel.text = "문제가 생겼어요!"
        } else {
            print("데이터 불러오기 성공")
            guard let buffer = buffer else {
                print("buffer is nil")
                return
            }
            let image = UIImage(data: buffer)
            nasaImage.image = image
        }
    }
}
