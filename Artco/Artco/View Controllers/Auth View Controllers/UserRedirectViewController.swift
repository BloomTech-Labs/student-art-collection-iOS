//
//  UserRedirectViewController.swift
//  Artco
//
//  Created by Mitchell Budge on 1/8/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import UIKit

class UserRedirectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buyerRedirectButtonTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "BuyerFlow", bundle: nil)
            let buyerTabBarController = storyboard.instantiateViewController(withIdentifier: "BuyerTabBarController")
            buyerTabBarController.modalPresentationStyle = .fullScreen
            self.present(buyerTabBarController, animated: true, completion: nil)
        }
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
