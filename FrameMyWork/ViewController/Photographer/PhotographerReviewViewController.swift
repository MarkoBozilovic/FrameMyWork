//
//  PhotographerReviewViewController.swift
//  FrameMyWork
//
//  Created by Stefana on 20/01/2021.
//
import StoreKit
import UIKit

class PhotographerReviewViewController: UIViewController {
    
    //MARK: - Outlets

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func rateTapped(_ sender: UIButton) {
        SKStoreReviewController.requestReview()
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
