//
//  VariationCollectionCell.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import UIKit
import Combine

class VariationCell: UICollectionViewCell {

    @IBOutlet private weak var variationTitleLabel: UILabel!
    @IBOutlet private weak var variationImageView: UIImageView!
    
    private var subscriptions = Set<AnyCancellable>()
    var viewModel: VariationCellViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.variationImageView.image = UIImage(named: "placeholder")
    }
    
    func prepareCell(viewModel: VariationCellViewModel) {
        self.viewModel = viewModel
        self.configureUI()
    }
    
    func configureUI() {
        viewModel?.$title
            .assign(to: \.text, on: variationTitleLabel)
            .store(in: &subscriptions)
        
        viewModel?.$imageURL.sink { [weak self] value in
            guard let url = URL(string: value ?? "") else { return }
            self?.variationImageView.kf.setImage(with: url, placeholder: UIImage.placeHolder)
        }.store(in: &subscriptions)
    }
}
