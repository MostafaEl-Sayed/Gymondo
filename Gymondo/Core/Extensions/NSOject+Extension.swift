//
//  NSOject+Extension.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation

extension NSObject {
    /// value that represent a className as string value
    static var className: String {
        return String(describing: self)
    }
}
