//
//  ExercisesImagesAPIs.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation
import Combine

extension ExercisesAPIs {
    func fetchMainImagePath(WithBaseId id: Int) -> AnyPublisher<[ExerciseImage], APIError> {
        let url = APIConstants.baseURL
            + APIConstants.imageAPI
            + "/?exercise_base=\(id)"
            + "&is_main=\(true)"
        return fetchImage(withURL: url)
    }
    
    func fetchImagesPaths(withId id: Int) -> AnyPublisher<[ExerciseImage], APIError> {
        let url = APIConstants.baseURL
            + APIConstants.imageAPI
            + "/?exercise_base=\(id)"
        return fetchImage(withURL: url)
    }
    
    private func fetchImage(withURL url: String) -> AnyPublisher<[ExerciseImage], APIError> {
        guard cachedImages[url] == nil else {
            return Result.Publisher(cachedImages[url] ?? []).eraseToAnyPublisher()
        }
        
        typealias Response = AnyPublisher<ExerciseImageResponse, APIError>
        let response: Response = APIManager.shared.requestAPI(url: url).eraseToAnyPublisher()
        return response.map {
            self.cachedImages[url] = $0.results
            return $0.results
        }.eraseToAnyPublisher()
    }
}
