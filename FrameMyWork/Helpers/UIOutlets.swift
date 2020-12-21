//
//  UIOutlets.swift
//  FrameMyWork
//
//  Created by Stefana on 21/12/2020.
//

import UIKit

func setupViewBackgroundOutlets(background: UIView) {
    background.layer.cornerRadius = 20
    background.layer.shadowOpacity = 0.2
    background.layer.shadowColor = UIColor.black.cgColor
    background.layer.shadowOffset = CGSize(width: 0, height: 0)
    background.layer.shadowRadius = 20
}

func setupButtons(button: UIButton) {
    button.layer.backgroundColor = UIColor.orange.cgColor
    button.titleLabel?.textColor = UIColor.white
    button.layer.cornerRadius = 5
}
