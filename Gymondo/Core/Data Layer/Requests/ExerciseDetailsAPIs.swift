//
//  ExerciseDetailsAPIs.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//
//

import Foundation
import Combine

extension ExercisesAPIs {
    func fetchExercises(withIds ids: [Int]) -> AnyPublisher<[Exercise], APIError> {
        let exercisesRequests = ids.map { fetchExercise(withId: $0) }
        return Publishers.MergeMany(exercisesRequests).collect().eraseToAnyPublisher()
    }
    
    func fetchExercise(withId id: Int) -> AnyPublisher<Exercise, APIError> {
        let url = APIConstants.baseURL + APIConstants.exerciseAPI + "/\(id)/"
        return APIManager.shared.requestAPI(url: url).eraseToAnyPublisher()
    }
    
    func fetchExerciseInfo(withId id: Int) -> AnyPublisher<Exercise, APIError> {
        let url = APIConstants.baseURL + APIConstants.exerciseInfoAPI + "/\(id)/"
        return APIManager.shared.requestAPI(url: url).eraseToAnyPublisher()
    }
}
