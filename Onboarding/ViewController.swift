//
//  ViewController.swift
//  Onboarding
//
//  Created by Valeria Muldt on 25.08.2020.
//  Copyright © 2020 Valeria Muldt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let isNewUser = UserDefaults.standard.bool(forKey: "isNewUser")
        if !isNewUser {
            // show onboarding
            let vc = storyboard?.instantiateViewController(withIdentifier: "onboarding") as! OnboardingViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }


}

