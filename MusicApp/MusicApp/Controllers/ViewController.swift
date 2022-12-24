//
//  ViewController.swift
//  MusicApp
//
//  Created by KSH on 2022/12/24.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var musicTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

