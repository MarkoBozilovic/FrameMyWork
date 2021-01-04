//
//  Utils.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 20.12.20..
//

import UIKit

func presentStoryboard(_ storyboard: String) {
    let window = UIApplication.shared.windows.first
    let storyboard = UIStoryboard(name: storyboard, bundle: .none)
    let vc = storyboard.instantiateInitialViewController()
    
    window?.rootViewController = vc
}

func selectStoryboard(for user: User) {
    switch user.role {
    case .member:
        presentStoryboard("Member")
    case .photographer:
        presentStoryboard("Photographer")
    default:
        assertionFailure("selectStoryboard() error")
    }
}
