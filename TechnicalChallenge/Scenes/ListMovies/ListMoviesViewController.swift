//
//  ListMoviesViewController.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 28/01/24.
//

import UIKit
import Foundation
import SVProgressHUD

protocol ListMoviesViewProtocol: AnyObject {
    func showAlert(title:String?, message: String?)
    func showListMovie(saved: Bool)
}

class ListMoviesViewController: UIViewController {
    @IBOutlet weak var listMoviesTableView: UITableView!
    @IBOutlet weak var listMoviesSearchBar: UISearchBar!
    @IBOutlet weak var footerIndicator: UIActivityIndicatorView!

    var presenter: ListMoviesPresenterProtocol?
    var configurator: ListMoviesConfiguratorProtocol?

    var isLoadingList = false
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configurator = ListMoviesConfigurator()
        configurator?.configure(viewController: self)

        let movieSearchToolBar = UIToolbar()
        let doneBtn = UIBarButtonItem(title: "Listo", style: .plain, target: self, action: #selector(handleViewTap))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        movieSearchToolBar.items = [flexSpace, flexSpace, doneBtn]
        movieSearchToolBar.sizeToFit()

        listMoviesSearchBar.returnKeyType = .done
        listMoviesSearchBar.showsCancelButton = true

        SVProgressHUD.show()

        listMoviesTableView.tableFooterView?.isHidden = true
        presenter?.getListMovies()
    }

    @objc func handleViewTap() {
        view.endEditing(true)
    }
}

extension ListMoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.clearSearchMovies()
        
        if let filteredMovies = presenter?.getMovies().filter({ ($0.title?.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current).contains(searchText.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)))! }) {
            presenter?.setSearchMovies(movies: searchText.isEmpty ? presenter?.getMovies() ?? [] : filteredMovies)
        }
        isSearching = true
        listMoviesTableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        listMoviesTableView.endEditing(true)
        isSearching = false
    }
}

extension ListMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            tableView.tableFooterView?.isHidden = true
            footerIndicator.stopAnimating()
            return presenter?.getSearchMovies().count ?? 0
        }
        return presenter?.getMovies().count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let movie = presenter?.getSearchMovies()[indexPath.row] {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ViewControllerIdentifier.listMoviesTableViewCell, for: indexPath) as! ListMoviesTableViewCell
            cell.setupCell(movie: movie)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell(frame: .zero)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            if let movie = presenter?.getSearchMovies()[indexPath.row] {
                presenter?.saveListMovies(movie: movie)
                presenter?.goToDetailMovies(movie: movie)
            }
        } else {
            if let movie = presenter?.getMovies()[indexPath.row] {
                presenter?.goToDetailMovies(movie: movie)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.presenter?.getPage() == self.presenter?.getTotalPages() || isSearching {
            listMoviesTableView.tableFooterView?.isHidden = true
            footerIndicator.stopAnimating()
            return
        }

        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height && !isLoadingList {
            isLoadingList = true
            presenter?.getListMovies()
        }
    }
}

extension ListMoviesViewController: ListMoviesViewProtocol {
    func showAlert(title: String?, message: String?) {
        DispatchQueue.global(qos: .default).async {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
        }
                
        let alert = Alerts.showAlert(title: title, message: message)
        self.present(alert, animated: true, completion: nil)
    }

    func showListMovie(saved: Bool) {
        DispatchQueue.global(qos: .default).async {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
        }
        isLoadingList = false
        listMoviesTableView.reloadData()

        if saved {
            listMoviesTableView.tableFooterView?.isHidden = true
            footerIndicator.stopAnimating()
        } else {
            listMoviesTableView.tableFooterView?.isHidden = false
            footerIndicator.startAnimating()
        }
    }
}
