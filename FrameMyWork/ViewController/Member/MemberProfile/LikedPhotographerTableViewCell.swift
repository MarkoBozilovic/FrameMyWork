//
//  LikedPhotographerTableViewCell.swift
//  FrameMyWork
//
//  Created by Stefana on 21/01/2021.
//

import UIKit

class LikedPhotographerTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet var photographerProfileImage: UIImageView!
    @IBOutlet var photographerName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
