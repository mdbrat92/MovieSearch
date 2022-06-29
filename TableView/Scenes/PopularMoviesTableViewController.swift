//
//  RecipesTableViewController.swift
//  TableView
//
//  Created by Basharat on 24/06/22..
//

import UIKit

class PopularMoviesTableViewController: UITableViewController {

    private let cellIdentifier: String = "tableCell"
    var data : [ResultObj]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let obj = MovieViewModel()
        obj.getMovieData{ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.data = response?.results
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    // MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetail",
            let indexPath = tableView?.indexPathForSelectedRow,
            let destinationViewController: MovieDetailsViewController = segue.destination as? MovieDetailsViewController {
            if let dataObj = data{
                destinationViewController.movie = dataObj[indexPath.row]
            }
        }
    }

}

extension PopularMoviesTableViewController {

    private func setupUI() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationItem.title = "Popular Movies"
        tableView.reloadData()
    }

}

// MARK: - UITableView DataSource

extension PopularMoviesTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableCell {
            if let dataObj = data{
                cell.configurateTheCell(dataObj[indexPath.row] )
            }
            return cell
        }
        return UITableViewCell()
    }

}

// MARK: - UITableView Delegate

extension PopularMoviesTableViewController {

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }

}
