//
//  RegisterViewController.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 2.1.21..
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Outlets
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var roleSegmentedControle: UISegmentedControl!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextFIeld: UITextField!
    @IBOutlet var dateOfBirthDatePicker: UIDatePicker!
    @IBOutlet var profileImageImageView: UIImageView!

    // MARK: - LifeCycleFunctions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
        
        subscribeToNotifications()
    }
    
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func cancelPressed() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func registerPressed() {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
//        let email = emailTextField.text!
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextFIeld.text!
        
        let newUser = User(username: username,
                           password: password,
                           role: roleSegmentedControle.selectedSegmentIndex)
        
        switch newUser.role {
        case .member:
            let newMember = Member(firstName: firstName,
                                   lastName: lastName,
                                   profileImage: nil)
            newUser.profile = newMember
        case .photographer:
            let newPhotographer = Photographer(firstName: firstName,
                                               lastName: lastName,
                                               profileImage: nil)
            newUser.profile = newPhotographer
        default:
            assertionFailure("unknow user role")
        }
        
        DataController.shared.registerUser(user: newUser) { (success) in
            if success {
                Model.shared.user = newUser
                selectStoryboard(for: Model.shared.user!)
            }
        }
    }
    
    // MARK: - Functions
    
    @objc func keyboardWillShow(notification: Notification) {
        guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
            return scrollView.contentInset = UIEdgeInsets.zero
        }
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let insets = UIEdgeInsets(top: 0,
                                  left: 0,
                                  bottom: keyboardViewEndFrame.height - 40,
                                  right: 0)
        
        scrollView.contentInset = insets
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            firstNameTextField.becomeFirstResponder()
        case firstNameTextField:
            lastNameTextFIeld.becomeFirstResponder()
        default:
            dismissKeyboard()
        }
        
        return true
    }
    
}
