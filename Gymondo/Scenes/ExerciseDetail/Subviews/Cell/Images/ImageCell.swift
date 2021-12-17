//
//  VariationCollectionCell.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import UIKit
import Combine

class ImageCell: UICollectionViewCell {
    
    @IBOutlet private weak var exImageView: UIImageView!
    
    private var subscriptions = Set<AnyCancellable>()
    var viewModel: ImageCellViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.exImageView.image = UIImage.transparentPlaceHolder
    }
    
    func prepareCell(viewModel: ImageCellViewModel) {
        self.viewModel = viewModel
        self.configureUI()
    }
    
    func configureUI() {
        viewModel?.$imageURL.sink { [weak self] value in
            guard let url = URL(string: value ?? "") else { return }
            self?.exImageView.kf.setImage(with: url, placeholder: UIImage.transparentPlaceHolder)
        }.store(in: &subscriptions)
    }
}
