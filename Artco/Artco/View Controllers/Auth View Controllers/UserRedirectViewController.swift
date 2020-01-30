//
//  UserRedirectViewController.swift
//  Artco
//
//  Created by Mitchell Budge on 1/8/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import UIKit
import Apollo

class UserRedirectViewController: UIViewController {
    
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func buyerRedirectButtonTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "BuyerFlow", bundle: nil)
            let buyerTabBarController = storyboard.instantiateViewController(withIdentifier: "BuyerTabBarController")
            buyerTabBarController.modalPresentationStyle = .fullScreen
            self.present(buyerTabBarController, animated: true, completion: nil)
        }
    }

}
