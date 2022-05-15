//
//  RepositoriesListTableViewController.swift
//  MVC-mobile-Challenge
//
//  Created by Rodrigo Eduardo Silva on 09/05/22.
//

import UIKit

class RepositoriesListTableViewController: UITableViewController {
    
    var model = RepositoriesListModel()
    var repository: [RepositoriesListModel.GitRepositories] = []
        
       override func viewDidLoad() {
        super.viewDidLoad()
           model.delegate = self
           model.loadRepositories()
    }
  
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return repository.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepositoriesListTableViewCell else{
            fatalError("Célula Não Encontrada")
        }
        let cellRepository = repository[indexPath.row]
        cell.prepareRepositoryCell(with: cellRepository)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            UITableView.automaticDimension
    }
}

extension RepositoriesListTableViewController: RepositoriesListModelDelegate {
    func updateRepositoriesModel() {
        repository += model.repositories
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
         }
    }
}
