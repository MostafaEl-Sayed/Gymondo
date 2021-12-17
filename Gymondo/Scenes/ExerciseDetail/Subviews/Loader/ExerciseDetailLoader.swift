//
//  ExerciseDetailLoader.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation
import UIKit

class ExerciseDetailLoader: UIView {
    @IBOutlet private var skeletonViews: [UIView]!
    @IBOutlet private var containerViews: [UIView]!

    func show() {
        skeletonViews.forEach({
            $0.startShimmering()
        })
        containerViews.forEach({
            $0.layer.cornerRadius = 12
            $0.startShimmering()
        })
    }

}
