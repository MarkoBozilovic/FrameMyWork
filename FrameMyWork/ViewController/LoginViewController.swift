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
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var registerBackgroundView: UIView!
    @IBOutlet var registerAsPhotographer: UIButton!
    @IBOutlet var registerAsMember: UIButton!

    // MARK: - LifeCycleFunctions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLoginOutlets()
        
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
        view.addSubview(registerBackgroundView)
        registerBackgroundView.center = view.center
        setupRegisterOutlets()
        signUpButton.alpha = 0
    }
    
    @IBAction func backToLogIn() {
      
    }
    
    @IBAction func photographerRegisterPressed() {
        performSegue(withIdentifier: "registerPhotographer", sender: nil)
    }
    
    @IBAction func memberRegisterPressed() {
        performSegue(withIdentifier: "registerMember", sender: nil)
    }
    
    // MARK: - Functions
    
    func setupLoginOutlets() {
        errorLabel.alpha = 0
        setupButtons(button: signInButton)
        setupViewBackgroundOutlets(background: backgroundView)
        
        registerBackgroundView.alpha = 0
        registerAsMember.alpha = 0
        registerAsPhotographer.alpha = 0
    }
    
    func setupRegisterOutlets() {
        registerBackgroundView.alpha = 1
        registerAsMember.alpha = 1
        registerAsPhotographer.alpha = 1
        backgroundView.alpha = 0
        setupButtons(button: registerAsMember)
        setupButtons(button: registerAsPhotographer)
        
        setupViewBackgroundOutlets(background: registerBackgroundView)
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
