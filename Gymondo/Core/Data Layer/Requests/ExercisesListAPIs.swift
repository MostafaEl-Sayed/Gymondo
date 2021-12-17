//
//  ExercisesListAPIs.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation
import Combine

extension ExercisesAPIs {
    func fetchAllExercises() -> AnyPublisher<[Exercise], APIError> {
        let url = APIConstants.baseURL + APIConstants.exerciseAPI
        typealias Response = AnyPublisher<ExercisesResponse, APIError>
        let response: Response = APIManager.shared.requestAPI(url: url)
        return response.map { $0.results }.eraseToAnyPublisher()
    }
}
