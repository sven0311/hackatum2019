//
//  ViewController.swift
//  Bay´n´b-Storyboard
//
//  Created by Sven Andabaka on 22.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
//        TODO
//        if (emailTextField.text?.isEmpty ?? true || passwordTextField.text?.isEmpty ?? true) {
//            let alert = UIAlertController(title: "Credentials wrong", message: "Email or Password Wrong", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "okay", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
//            return
//        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vC = storyboard.instantiateViewController(identifier: "Main")
        
        UIApplication.shared.keyWindow?.rootViewController = vC
    }
    
}

