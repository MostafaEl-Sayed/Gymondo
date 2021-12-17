//
//  ExerciseImage.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation

struct ExerciseImageResponse: Decodable {
    let results: [ExerciseImage]
}

struct ExerciseImage: Decodable {
    let imagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case imagePath = "image"
    }
    
    init(imagePath: String? = nil) {
        self.imagePath = imagePath
    }
}
