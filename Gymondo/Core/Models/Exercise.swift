//
//  Exercises.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation

struct ExercisesResponse: Decodable {
    let count: Int?
    let results: [Exercise]
}

struct Exercise: Decodable {
    let id: Int?
    let uuid: String?
    let name: String?
    let exerciseBase: Int?
    let status: String?
    let description: String?
    let creationDate: String?
    let category: Int?
    let muscles: [Int]?
    let musclesSecondary: [Int]?
    let equipment: [Int]?
    let language, license: Int?
    let licenseAuthor: String?
    let variations: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id, uuid, name
        case exerciseBase = "exercise_base"
        case status
        case description
        case creationDate = "creation_date"
        case category, muscles
        case musclesSecondary = "muscles_secondary"
        case equipment, language, license
        case licenseAuthor = "license_author"
        case variations
    }
    
}
