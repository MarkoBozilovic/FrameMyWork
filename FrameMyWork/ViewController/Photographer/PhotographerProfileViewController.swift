//
//  PhotographerProfileViewController.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 20.12.20..
//

import UIKit

class PhotographerProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Properties
//    let gallery = PhotographerGalleryViewController()
//    let review = PhotographerReviewViewController()
    
    //MARK: - Outlets
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var aboutTextView: UITextView!
    @IBOutlet var galleryReviewSegmentedControl: UISegmentedControl!
    @IBOutlet weak var galleryContainer: UIView!
    @IBOutlet weak var reviewContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = Model.shared.user!.profile!.firstName + " " + Model.shared.user!.profile!.lastName
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func editImagePressed() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func didTapSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.galleryContainer.alpha = 1
            self.reviewContainer.alpha = 0
        } else {
            self.galleryContainer.alpha = 0
            self.reviewContainer.alpha = 1
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            profileImage.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
