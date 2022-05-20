import UIKit

class RepositoriesListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var model = RepositoriesListModel()
    var repository: [GitRepository] = []
    var totalrepositories: GitHead!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        model.delegate = self
        model.loadRepositories()
    }
  
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return repository.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepositoriesListTableViewCell else{
            fatalError("Célula Não Encontrada")
        }
        let cellRepository = repository[indexPath.row]
        cell.prepareRepositoryCell(with: cellRepository)
        return cell
    }
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == repository.count - 20 && !model.rechargeList && repository.count != model.totalrepository{
            model.currentPage += 1
            model.loadRepositories()
            print("Total de Repositórios: \(model.totalrepository) , Já Inclusos : \(repository.count)")
        }
    }
}

extension RepositoriesListTableViewController: RepositoriesListModelDelegate {
    func updateRepositoriesModel() {
        repository += model.repositories
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.model.rechargeList = false
         }
    }
}
