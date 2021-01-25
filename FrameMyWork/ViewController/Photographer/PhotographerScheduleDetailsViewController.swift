//
//  PhotographerScheduleDetailsViewController.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 18.1.21..
//

import UIKit

class PhotographerScheduleDetailsViewController: UIViewController {
    // MARK: - Outlets
    
    @IBOutlet var sendMessageButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var memberLabel: UILabel!
    @IBOutlet var occasionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    
    // MARK: - Properties
    
    var schedule: Schedule?
    var member: Member?
    
    // MARK: - ViewLifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        DataController.shared.getMember(by: self.schedule!.memberId) { (member) in
            guard member != nil else { return }
            self.member = member!
            self.setupOutlets()
        }
        
    }
    
    // MARK: - Actions
    
    // MARK: - Functions

    func setupOutlets() {
        // Buttons
        sendMessageButton.layer.cornerRadius = 5
        cancelButton.layer.cornerRadius = 5
        
        memberLabel.text = "\(member!.firstName) \(member!.lastName)"
        occasionLabel.text = schedule!.title
        detailsLabel.text = schedule!.details
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "d.MM.yy"
        dateLabel.text = dateFormater.string(from: schedule!.date)
        
    }
}
