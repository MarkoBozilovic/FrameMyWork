//
//  LoginViewController.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 5.12.20..
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Outlets
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInButton: UIButton!

    // MARK: - LifeCycleFunctions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupOutlets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Actions
    
    @IBAction func signInPressed() {
        do {
            let username = try ValidationService.validateUsername(username: usernameTextField.text)
            let password = try ValidationService.validatePassword(password: passwordTextField.text)
            
            DataController.shared.login(username: username,
                                        password: password) { (success) in
                if success {
                    switch Model.shared.user?.role {
                    case .photographer:
                            presentStoryboard("Photographer")
                    default:
                            assertionFailure("Not Photographer")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showError(LoginValidationError.incorrectCredentials)
                    }
                }
            }
        }
        catch {
            showError(error as! LoginValidationError)
        }
    }
    
    @IBAction func signUpPressed() {
        
    }
    
    // MARK: - Functions
    
    func setupOutlets() {
        errorLabel.alpha = 0
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.shadowOpacity = 0.2
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundView.layer.shadowRadius = 20
        signInButton.layer.cornerRadius = 5

    }
    
    func showError(_ error: LoginValidationError) {
        errorLabel.text = ValidationService.generateErrorMessage(for: error)
        errorLabel.alpha = 1
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            signInPressed()
        }
        return true
    }
}
