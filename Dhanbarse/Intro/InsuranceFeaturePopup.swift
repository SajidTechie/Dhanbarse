//
//  InsuranceFeaturePopup.swift
//  Dhanbarse
//
//  Created by Goldmedal on 7/27/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import UIKit

class InsuranceFeaturePopup: UIViewController {
    
    @IBOutlet weak var imvClose: UIImageView!
    @IBOutlet weak var imvNewFeature: UIImageView!
    @IBOutlet weak var vwClose: UIView!
    @IBOutlet weak var vwMain: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Inside Insurance popup  - - - - - -  - - - - - -")
        
        let tabClose = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        vwClose.addGestureRecognizer(tabClose)
        
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        dismiss(animated: true)
    }
    
    @IBAction func clicked_show(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "LeftPanel", bundle: nil)
        let vcInsuranceDetail = storyBoard.instantiateViewController(withIdentifier: "InsuranceListViewController") as! InsuranceListViewController
        self.navigationController!.pushViewController(vcInsuranceDetail, animated: false)
    }
    
}

