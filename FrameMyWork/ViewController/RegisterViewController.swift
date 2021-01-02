//
//  RegisterViewController.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 2.1.21..
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: - Outlets
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var roleSegmentedControle: UISegmentedControl!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
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
}
