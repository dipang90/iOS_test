//
//  TabBarController.swift
//  iOS_Market
//
//  Created by Dipang Sheth on 31/10/18.
//  Copyright © 2018 Dipang Sheth. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let button = UIButton.init(type: .custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setImage(UIImage.init(named: "Composed-layer"), for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.1
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(TabBarController.selectCenterIndex), for: .touchUpInside)
        tabBar.addSubview(button)
        self.selectedIndex = 3
        // Do any additional setup after loading the view.
    }
    
    @objc func selectCenterIndex() {
        self.selectedIndex = 2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // safe place to set the frame of button manually
        button.frame = CGRect.init(x: self.tabBar.center.x - 30, y: self.view.bounds.height - 115, width: 60, height: 60)
        button.center = CGPoint(x: tabBar.frame.width / 2, y: 0)
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
