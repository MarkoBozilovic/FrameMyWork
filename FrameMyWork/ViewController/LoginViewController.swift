//
//  LoginViewController.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 5.12.20..
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Outlets
    
    @IBOutlet var loginBackgroundView: UIView!
    @IBOutlet var errorLabel: UILabel!

    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()

        outletSetup()
    }
    
    // MARK: - Functions
    
    func outletSetup() {
        loginBackgroundView.layer.cornerRadius = 30
        loginBackgroundView.backgroundColor = UIColor(red: 250, green: 0, blue: 0, alpha: 0.1)
    }
}
