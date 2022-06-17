import UIKit

class RepositoriesListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var model = RepositoriesListModel()
    var repositories: [GitRepository] {
        model.repositories
    }
    var totalrepositories: GitHead!
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Carregando Repositórios.Aguarde..."
        tableView.dataSource = self
        tableView.delegate = self
        model.delegate = self
        model.loadRepositories()
    }
    func showPullrequest(repository: GitRepository) {
        let repository = repositories[tableView.indexPathForSelectedRow!.row]
        let viewController = PullRequestListViewController.create(repository: repository)
        navigationController?.pushViewController(viewController, animated: true)
    }
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = repositories.count == 0 ? label : nil
        return repositories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepositoriesListTableViewCell else {
            fatalError("Célula Não Encontrada")
        }
        let cellRepository = repositories[indexPath.row]
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
        if indexPath.row == repositories.count - 2 && !model.rechargeList && repositories.count != model.totalrepository {
            model.currentPage += 1
            model.loadRepositories()
            print("Total de Repositórios: \(model.totalrepository) , Já Inclusos : \(repositories.count)")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        showPullrequest(repository: repository)
    }
}

extension RepositoriesListTableViewController: RepositoriesListModelDelegate {
    func updateRepositoriesModel() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.model.rechargeList = false
         }
    }
}

extension RepositoriesListTableViewController {
    static func create() -> RepositoriesListTableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewcontroller = storyboard.instantiateViewController(withIdentifier: "RepositoriesListTableViewController") as? RepositoriesListTableViewController else {
            fatalError()
        }
        return viewcontroller
    }
}
