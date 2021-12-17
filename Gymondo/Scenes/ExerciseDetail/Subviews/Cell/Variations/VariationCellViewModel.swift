//
//  VariationCellViewModel.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation
import Combine

class VariationCellViewModel {
    // MARK:- Instances
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK:- Output
    @Published private(set) var title: String?
    @Published private(set) var imageURL: String?
    
    // MARK:- Init
    init(exerciseVariation exercise: Exercise) {
        self.title = exercise.name
        self.loadImage(id: exercise.exerciseBase ?? -1)
    }
    
    func loadImage(id: Int) {
        ExercisesAPIs.shared.fetchMainImagePath(WithBaseId: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] exerciseImages in
                guard let img = exerciseImages.first else { return }
                self?.imageURL = img.imagePath
            }).store(in: &subscriptions)
    }
}
