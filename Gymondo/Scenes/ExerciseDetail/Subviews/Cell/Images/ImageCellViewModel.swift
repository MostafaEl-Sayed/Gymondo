//
//  VariationCellViewModel.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation
import Combine

class ImageCellViewModel {
    // MARK:- Instances
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK:- Output
    @Published private(set) var imageURL: String?
    
    // MARK:- Init
    init(imageURL: String) {
        self.imageURL = imageURL
    }
}
