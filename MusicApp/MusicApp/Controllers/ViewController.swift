//
//  ViewController.swift
//  MusicApp
//
//  Created by KSH on 2022/12/24.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var musicTableView: UITableView!
    
    // 네트워크 매니저 (싱글톤)
    var networkManager = NetworkManager.shared
    
    // (음악 데이터를 다루기 위함) 빈배열로 시작
    var musicArrays: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupDatas()
        
    }
    
    // 테이블뷰 셋팅
    func setupTableView() {
        musicTableView.dataSource = self
        musicTableView.delegate = self
        
        // Nib파일을 사용한다면 등록의 과정이 필요
        musicTableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
        
        //musicTableView.rowHeight = 120
    }
    
    // 데이터 셋업
    func setupDatas() {
        // 네트워킹의 시작
        networkManager.fetchMusic(searchTerm: "BTS") { result in
            print(#function)
            switch result {
            case .success(let musicDatas):
                // 데이터(배열)을 받아오고 난 후
                self.musicArrays = musicDatas
                // 테이블뷰 리로드
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return self.musicArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MusicCell
        
        
        cell.imageUrl = musicArrays[indexPath.row].imageUrl
        
        cell.songNameLabel.text = musicArrays[indexPath.row].songName
        cell.artistNameLabel.text = musicArrays[indexPath.row].artistName
        cell.albumNameLabel.text = musicArrays[indexPath.row].albumName
        cell.releaseDateLabel.text = musicArrays[indexPath.row].releaseDateString
        
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    // 테이블뷰 셀의 높이를 유동적으로 조절하고 싶다면 구현할 수 있는 메서드
    // (musicTableView.rowHeight = 120 대신에 사용가능)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // 자동적으로 셀의 높이를 정해주는 메서드
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}

