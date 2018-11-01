//
//  BaseViewController.swift
//  iOS_Market
//
//  Created by Dipang Sheth on 01/11/18.
//  Copyright © 2018 Dipang Sheth. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(UIImage.init(named: "search"), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        searchButton.addTarget(self, action: #selector(BaseViewController.searchView), for: .touchUpInside)
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(searchButton)
        searchButton.clipsToBounds = true
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                                  constant: -10),
            searchButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                                   constant: -15),
            searchButton.heightAnchor.constraint(equalToConstant: 20),
            searchButton.widthAnchor.constraint(equalToConstant: 20)
            ])
        
        // Do any additional setup after loading the view.
    }
    
    @objc func searchView() {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
