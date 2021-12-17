//
//  ExercisesAPIs.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation
import Combine

class ExercisesAPIs {
    static let shared = ExercisesAPIs()
    var cachedImages: [String: [ExerciseImage]] = [:]
    private init() {}
}


