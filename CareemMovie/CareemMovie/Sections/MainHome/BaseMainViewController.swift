//
//  BaseMainViewController.swift
//  ListingRestaurant
//
//  Created by Tran Hoang Canh on 28/2/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit

class BaseMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBaseMainBackGroundView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
    private func setupBaseMainBackGroundView() {
        let blurImageView = UIImageView(frame: UIScreen.main.bounds)
        blurImageView.contentMode = .scaleAspectFill
        blurImageView.image = UIImage(named: "Background_Blur")
        
        
        let overLayView = UIView(frame: UIScreen.main.bounds)
        overLayView.backgroundColor = UIColor(hex: "FF4E50").withAlphaComponent(0.1)
        
        self.view.insertSubview(overLayView, at: 0)
        self.view.insertSubview(blurImageView, at: 0)
    }

}
