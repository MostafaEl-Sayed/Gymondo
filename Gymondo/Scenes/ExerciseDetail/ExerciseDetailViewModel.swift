//
//  ExerciseDetailViewModel.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation
import Combine

class ExerciseDetailViewModel {
    
    var id: Int
    var numberOfVariations: Int { return variations.count }
    var numberOfImgs: Int { return images.count }
    private var subscriptions = Set<AnyCancellable>()
    private var variations: [Exercise] = []
    private var images: [ExerciseImage] = []
    private var exercise: Exercise?
    
    // MARK: Output
    @Published private(set) var name: String?
    @Published private(set) var isLoading: Bool = false
    private let reloadImgsSubject = PassthroughSubject<Void, APIError>()
    private let reloadVariationsSubject = PassthroughSubject<Void, APIError>()
    var reloadImgs: AnyPublisher<Void, APIError> {
        reloadImgsSubject.eraseToAnyPublisher()
    }
    var reloadVariations: AnyPublisher<Void, APIError> {
        reloadVariationsSubject.eraseToAnyPublisher()
    }

    init(id: Int) {
        self.id = id
        self.loadInfo()
    }

    private func loadInfo() {
        isLoading = true
        ExercisesAPIs.shared.fetchExercise(withId: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] exercise in
                    self?.exercise = exercise
                    self?.loadImage(id: exercise.exerciseBase ?? -1)
                    self?.name = exercise.name
                    self?.loadVariations(ids: exercise.variations ?? [])
                  }
            ).store(in: &subscriptions)
    }

    func loadImage(id: Int) {
        ExercisesAPIs.shared.fetchImagesPaths(withId: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] exerciseImages in
                self?.images = exerciseImages.isEmpty
                    ? [ExerciseImage()] : exerciseImages
                self?.reloadImgsSubject.send()
            }).store(in: &subscriptions)
    }
    
    private func loadVariations(ids: [Int]) {
        ExercisesAPIs.shared.fetchExercises(withIds: ids)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completed in
                self?.isLoading = false
                self?.reloadVariationsSubject.send(completion: completed)
            }, receiveValue: { [weak self] variations in
                self?.variations = variations
                self?.reloadVariationsSubject.send()
            }).store(in: &subscriptions)
    }
    

    func variationCellViewModel(indexPath: IndexPath) -> VariationCellViewModel {
        let exercise = variations[indexPath.row]
        return VariationCellViewModel(exerciseVariation: exercise)
    }
    
    func imgCellViewModel(indexPath: IndexPath) -> ImageCellViewModel {
        let imageInfo = images[indexPath.row]
        return ImageCellViewModel(imageURL: imageInfo.imagePath ?? "")
    }

    func exercisesDetailsViewModel(indexPath: IndexPath) -> ExerciseDetailViewModel {
        ExerciseDetailViewModel(id: variations[indexPath.row].id ?? -1)
    }
}
