//
//  MarketViewController.swift
//  iOS_Market
//
//  Created by Dipang Sheth on 01/11/18.
//  Copyright © 2018 Dipang Sheth. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl

class MarketViewController: BaseViewController {
    
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let storyboardName = UIStoryboard(name: "Market", bundle: Bundle.main)
    private lazy var moneyTransferViewController: MoneyTransferViewController = {
        var viewController = storyboardName.instantiateViewController(withIdentifier:"MoneyTransferId") as! MoneyTransferViewController
        return viewController
    }()
    private lazy var insuranceViewController: InsuranceViewController = {
        var viewController = storyboardName.instantiateViewController(withIdentifier:"InsuranceId") as! InsuranceViewController
        return viewController
    }()
    private lazy var creditViewController: CreditViewController = {
        var viewController = storyboardName.instantiateViewController(withIdentifier:"CreditId") as! CreditViewController
        return viewController
    }()
    private lazy var loansViewController: LoansViewController = {
        var viewController = storyboardName.instantiateViewController(withIdentifier:"LoansId") as! LoansViewController
        return viewController
    }()
    
    var arrayViewController : [UIViewController]!
    let screen = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Markets"
        arrayViewController = [moneyTransferViewController, insuranceViewController, creditViewController, loansViewController]
        self.setCollectionView()
        self.setHeader()
        

        // Do any additional setup after loading the view.
    }
    
    private func setCollectionView()  {
        collectionView.register(UINib(nibName: "BaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.collectionView.isPagingEnabled = true
        self.collectionView.isScrollEnabled = true
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: screen.width, height: screen.height - 144)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
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

extension MarketViewController {
    func setHeader()  {
        segmentedControl.segmentStyle = .textOnly
        segmentedControl.insertSegment(withTitle: "MoneyTransfer", image: nil, at: 0)
        segmentedControl.insertSegment(withTitle: "InsuranceId", image: nil, at: 1)
        segmentedControl.insertSegment(withTitle: "Credit", image: nil, at: 2)
        segmentedControl.insertSegment(withTitle: "Loans", image: nil, at: 3)
        segmentedControl.underlineSelected = true
        
        segmentedControl.addTarget(self, action: #selector(MarketViewController.segmentSelected(sender:)), for: .valueChanged)
        segmentedControl.addTarget(self, action: #selector(MarketViewController.segmentSelected(sender:)), for: .touchUpInside)
        segmentedControl.tintColor = Colors.SteelGray.color()
        segmentedControl.backgroundColor = Colors.WildSand.color()
        let largerRedTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: Colors.Silver.color()]
        let largerRedTextHighlightAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: Colors.SteelGray.color()]
        let largerRedTextSelectAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor:Colors.SteelGray.color()]
        segmentedControl.setTitleTextAttributes(largerRedTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(largerRedTextHighlightAttributes, for: .highlighted)
        segmentedControl.setTitleTextAttributes(largerRedTextSelectAttributes, for: .selected)
        segmentedControl.selectedSegmentIndex = 0
        setScrollViewItem(row: 0)
        // self.collectionView.reloadData()
    }
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        sender.underlineSelected = true
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
        setScrollViewItem(row: sender.selectedSegmentIndex)
    }
    
    func setScrollViewItem (row : Int)  {
        let indexToScrollTo = IndexPath(item: row, section: 0)
        self.collectionView.scrollToItem(at: indexToScrollTo, at: .left, animated: true)
    }
}


extension MarketViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayViewController.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screen.width, height: screen.height - 144)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        self.addView(asChildViewController: self.arrayViewController[indexPath.row], cell: cell as! BaseCollectionViewCell)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells  as [UICollectionViewCell]    {
            let indexPath = collectionView.indexPath(for: cell as UICollectionViewCell)
            DispatchQueue.main.async {
                self.segmentedControl.selectedSegmentIndex = indexPath!.last!
                self.segmentedControl.underlineSelected = true
            }
        }
    }
    
    func addView(asChildViewController viewController: UIViewController, cell : BaseCollectionViewCell) {
        // Add Child View Controller
        self.addChildViewController(viewController)
        let topConstraint = NSLayoutConstraint(item: viewController.view, attribute: .top, relatedBy: .equal, toItem: cell.baseView, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: viewController.view, attribute: .bottom, relatedBy: .equal, toItem: cell.baseView, attribute: .bottom, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: viewController.view, attribute: .trailing, relatedBy: .equal, toItem: cell.baseView, attribute: .trailing, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: viewController.view, attribute: .leading, relatedBy: .equal, toItem: cell.baseView, attribute: .leading, multiplier: 1, constant: 0)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        cell.baseView.addSubview(viewController.view)
        cell.baseView.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        cell.baseView.layoutIfNeeded()
        viewController.didMove(toParentViewController: self)
    }
}

