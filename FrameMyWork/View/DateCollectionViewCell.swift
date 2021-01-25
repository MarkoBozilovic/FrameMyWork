//
//  DateCollectionViewCell.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 10.1.21..
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    
    @IBOutlet var dateLabel: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.cornerRadius = 25
        self.backgroundColor = UIColor.red
    }
}
