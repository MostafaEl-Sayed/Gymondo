//
//  UICollectionView+Extension.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let nib = UINib(nibName: cellType.className, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: cellType.className)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath)
        // swiftlint:disable force_cast
        return cell as! T
    }
}
