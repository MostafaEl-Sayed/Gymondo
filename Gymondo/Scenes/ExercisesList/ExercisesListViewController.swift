//
//  ExercisesListViewController.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import UIKit
import Combine

class ExercisesListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    // MARK: - Instances
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel = ExercisesListViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.configureBindings()
    }
    
    // MARK: - Configurations
    func configureTableView() {
        tableView.register(cellType: ExercisesListCell.self)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }

    // MARK: - Private Helpers
    private func configureBindings() {
        viewModel.reloadTable
            .sink(receiveCompletion: { completion in
                switch completion {
                //Show error here
                case .failure(_): return
                case .finished: return
                }
            }) { [weak self] _ in
                self?.tableView.reloadData()
                self?.indicator.stopAnimating()
            }.store(in: &subscriptions)
    }
}

// MARK: - UITableViewDelegate
extension ExercisesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exerciseDetailsVC = ExerciseDetailViewController()
        exerciseDetailsVC.viewModel = viewModel.exercisesDetailsViewModel(indexPath: indexPath)
        self.navigationController?.pushViewController(exerciseDetailsVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ExercisesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExercisesListCell = tableView.dequeueReusableCell(for: indexPath)
        cell.prepareCell(viewModel: viewModel.cellViewModel(indexPath: indexPath))
        return cell
    }
}
