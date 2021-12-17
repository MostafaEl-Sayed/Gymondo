//
//  ExerciseDetailViewController.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import UIKit
import Combine

class ExerciseDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imgsCollection: UICollectionView!
    @IBOutlet private weak var variationCollection: UICollectionView!
    @IBOutlet private weak var variationStack: UIStackView!
    
    // MARK: - Instances
    private var subscriptions = Set<AnyCancellable>()
    var viewModel: ExerciseDetailViewModel!
    private lazy var exerciseDetailLoaderView: ExerciseDetailLoader?  = ExerciseDetailLoader.createInstanceFromNib()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.configureBindings()
    }
    
    // MARK: - Configurations
    func configureTableView() {
        variationCollection.register(cellType: VariationCell.self)
        variationCollection.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        imgsCollection.register(cellType: ImageCell.self)
        imgsCollection.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    private func configureBindings() {
        viewModel?.$name
            .assign(to: \.text, on: titleLabel)
            .store(in: &subscriptions)
        
        viewModel.$isLoading.sink { [weak self] value in
            if value {
                self?.startViewLoading()
            } else {
                self?.stopViewLoading()
            }
        }.store(in: &subscriptions)
        
        viewModel.reloadVariations.sink { [weak self] completion in
            self?.variationStack.isHidden = self?.viewModel.numberOfVariations == 0
        } receiveValue: { [weak self] _ in
            self?.variationCollection.reloadData()
        }.store(in: &subscriptions)
        
        viewModel.reloadImgs.sink { completion in
        } receiveValue: { [weak self] _ in
            self?.imgsCollection.reloadData()
        }.store(in: &subscriptions)
        
    }
    
    private func startViewLoading() {
        exerciseDetailLoaderView?.frame = self.view.frame
        exerciseDetailLoaderView?.show()
        view.addSubview(exerciseDetailLoaderView!)
    }
    
    func stopViewLoading() {
        exerciseDetailLoaderView?.removeFromSuperview()
        exerciseDetailLoaderView?.stopShimmering()
        exerciseDetailLoaderView = nil
    }
}

// MARK: - UICollectionViewDataSource
extension ExerciseDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == imgsCollection ? viewModel.numberOfImgs : viewModel.numberOfVariations
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imgsCollection {
            let cell: ImageCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.prepareCell(viewModel: viewModel.imgCellViewModel(indexPath: indexPath))
            return cell
        } else {
            let cell: VariationCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.prepareCell(viewModel: viewModel.variationCellViewModel(indexPath: indexPath))
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ExerciseDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imgsCollection {
            return CGSize(width: UIScreen.main.bounds.width - 16, height: 200)
        } else {
            return CGSize(width: 120, height: 120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == variationCollection else { return }
        let exerciseDetailsVC = ExerciseDetailViewController()
        exerciseDetailsVC.viewModel = viewModel.exercisesDetailsViewModel(indexPath: indexPath)
        self.navigationController?.pushViewController(exerciseDetailsVC, animated: true)
    }
}
