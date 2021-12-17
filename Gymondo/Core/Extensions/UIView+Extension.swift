//
//  UIView+Extension.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import UIKit
import SkeletonView

// MARK: - InstanceFromNib
extension UIView {
    class func createInstanceFromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        else { fatalError("missing expected nib named: \(name)") }
        guard
            let view = nib.first as? Self
        else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
}

// MARK: - Shimmering
extension UIView {
    func startShimmering() {
        self.isSkeletonable = true
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        self.showAnimatedGradientSkeleton(animation: animation)
    }

    func stopShimmering() {
        self.isSkeletonable = false
        self.stopSkeletonAnimation()
        self.hideSkeleton(transition: .crossDissolve(0.25))
    }
}
