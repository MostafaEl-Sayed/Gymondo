//
//  ExercisesListCell.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 14/12/2021.
//

import UIKit
import Combine
import Kingfisher

class ExercisesListCell: UITableViewCell {
    
    @IBOutlet weak var exerciseImgView: UIImageView!
    @IBOutlet weak var exerciseTitleLabel: UILabel!
    
    private var subscriptions = Set<AnyCancellable>()
    var viewModel: ExercisesListCellViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.exerciseImgView.image = UIImage.placeHolder
    }
    
    func prepareCell(viewModel: ExercisesListCellViewModel) {
        self.viewModel = viewModel
        self.configureUI()
    }
    
    func configureUI() {
        viewModel?.$title
            .assign(to: \.text, on: exerciseTitleLabel)
            .store(in: &subscriptions)
        
        viewModel?.$imageURL.sink { [weak self] value in
            guard let url = URL(string: value ?? "") else { return }
            self?.exerciseImgView.kf.setImage(with: url, placeholder: UIImage.placeHolder)
        }.store(in: &subscriptions)
    }
}
