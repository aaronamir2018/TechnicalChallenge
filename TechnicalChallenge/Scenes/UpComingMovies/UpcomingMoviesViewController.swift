//
//  UpcomingMoviesViewController.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 24/01/24.
//

import UIKit
import SVProgressHUD

protocol PresenterToViewUpcomingMoviesProtocol: BaseViewControllerProtocol {
    func reloadTableViewData(with getMoviesViewModel: UpcomingMovies.GetMovies.ViewModel)
}

final class UpcomingMoviesViewController: BaseViewController {
        
        @IBOutlet weak var tableView: UITableView!
                
        var interactor: ViewToInteractorUpcomingMoviesProtocol?
        var router: ViewToRouterUpcomingMoviesProtocol?
                
        private var movies: [UpcomingMovieViewModel] = []
                
        init() {
            super.init(nibName: nil, bundle: nil)
            UpcomingMoviesConfigurator.injectDependencies(for: self)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            UpcomingMoviesConfigurator.injectDependencies(for: self)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            interactor?.viewDidLoad()
        }
    }

    extension UpcomingMoviesViewController {
        func updateMovieSuccess() {
            interactor?.reloadTableViewData()
        }
    }

    extension UpcomingMoviesViewController: PresenterToViewUpcomingMoviesProtocol {
        func reloadTableViewData(with getMoviesViewModel: UpcomingMovies.GetMovies.ViewModel) {
            self.movies = getMoviesViewModel.movies
            tableView.reloadData()
        }
    }

    private extension UpcomingMoviesViewController {
        func setupUI() {
            tableView.register(UpcomingMovieCell.self)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    extension UpcomingMoviesViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return movies.count
        }
        
        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeue(UpcomingMovieCell.self, for: indexPath)
            cell.update(with: movies[indexPath.row])
            return cell
        }
    }

    extension UpcomingMoviesViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            router?.navigateToEditMovieView()
        }
        
        func tableView(_ tableView: UITableView,
                       heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    }
