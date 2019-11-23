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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginSpinner.alpha = 0.0
    }

    @IBAction func login(_ sender: Any) {
//        TODO
//        if (emailTextField.text?.isEmpty ?? true || passwordTextField.text?.isEmpty ?? true) {
//            let alert = UIAlertController(title: "Credentials wrong", message: "Email or Password Wrong", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "okay", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
//            return
//        }
        
        UIView.animate(withDuration: 0.35, animations: {
            self.emailTextField.alpha = 0.0
            self.passwordTextField.alpha = 0.0
            self.loginButton.alpha = 0.0
        }, completion: nil)
        
        logoVerticalConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.loginSpinner.alpha = 1.0
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.5, execute: {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vC = storyboard.instantiateViewController(identifier: "Main")
    
            UIApplication.shared.keyWindow?.rootViewController = vC
        })
    }
    
}

