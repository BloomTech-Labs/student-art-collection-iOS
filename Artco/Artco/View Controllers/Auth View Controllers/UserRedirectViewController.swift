//
//  UserRedirectViewController.swift
//  Artco
//
//  Created by Mitchell Budge on 1/8/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import UIKit

class UserRedirectViewController: UIViewController {
    
    @IBAction func buyerRedirectButtonTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "BuyerFlow", bundle: nil)
            let buyerTabBarController = storyboard.instantiateViewController(withIdentifier: "BuyerTabBarController")
            buyerTabBarController.modalPresentationStyle = .fullScreen
            self.present(buyerTabBarController, animated: true, completion: nil)
        }
    }

}
