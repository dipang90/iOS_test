//
//  MoneyTransferViewController.swift
//  iOS_Market
//
//  Created by Dipang Sheth on 31/10/18.
//  Copyright © 2018 Dipang Sheth. All rights reserved.
//

import UIKit

class MoneyTransferViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rowNib = UINib(nibName: "MoneyTableViewCell", bundle: Bundle.main)
        self.tableView.register(rowNib, forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
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

extension MoneyTransferViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 358
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView ()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoneyTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.transitionFlipFromTop, .showHideTransitionViews], animations: {
                self.navigationController?.isNavigationBarHidden = true
                self.tabBarController?.tabBar.isHidden = true
            }, completion: { (finished) in
            })
        }
        if (scrollView.contentOffset.y <= 0){
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.transitionFlipFromBottom, .showHideTransitionViews], animations: {
                self.navigationController?.isNavigationBarHidden = false
                self.tabBarController?.tabBar.isHidden = false
                }, completion: { (finished) in
            })
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if (actualPosition.y > 0){
            // Dragging down
            print("down")
            UIView.animate(withDuration: 0.2, delay: 0.1, options: [.transitionFlipFromBottom, .showHideTransitionViews], animations: {
                self.tabBarController?.tabBar.isHidden = false
                }, completion: { (finished) in
            })
        }else{
            // Dragging up
            print("up")
        }
    }
}
