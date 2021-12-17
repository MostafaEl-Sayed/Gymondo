//
//  ExercisesListViewModel.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation
import Combine

class ExercisesListViewModel {

    private var subscriptions = Set<AnyCancellable>()
    private var exercises = [Exercise]()
    var numberOfRows: Int { return exercises.count }
    
    // MARK: Output
    private let reloadTableSubject = PassthroughSubject<Void, APIError>()
    var reloadTable: AnyPublisher<Void, APIError> {
        reloadTableSubject.eraseToAnyPublisher()
    }

    init() {
        ExercisesAPIs.shared.fetchAllExercises()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completed in
                self?.reloadTableSubject.send(completion: completed)
            }, receiveValue: { [weak self] exercises in
                self?.exercises = exercises
                self?.reloadTableSubject.send()
            }).store(in: &subscriptions)
    }

    func cellViewModel(indexPath: IndexPath) -> ExercisesListCellViewModel {
        let exercise = exercises[indexPath.row]
        return ExercisesListCellViewModel(exercise: exercise)
    }

    func exercisesDetailsViewModel(indexPath: IndexPath) -> ExerciseDetailViewModel {
        ExerciseDetailViewModel(id: exercises[indexPath.row].id ?? -1)
    }
}
