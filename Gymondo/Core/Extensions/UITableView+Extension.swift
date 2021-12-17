//
//  UITableView+Extension.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(cellType: T.Type) {
        let nib = UINib(nibName: cellType.className, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellType.className)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: T.className, for: indexPath)
        // swiftlint:disable force_cast
        return cell as! T
    }
}
