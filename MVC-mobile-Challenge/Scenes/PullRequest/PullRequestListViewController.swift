import UIKit

class PullRequestListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    var pullrequest: [PullRequest] = []
    var pullmodel = PullRequestListModel()
    var linkpullrequest: GitRepository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        pullmodel.delegate = self
        pullmodel.loadPullRequest(owner: linkpullrequest.owner.login, repository: linkpullrequest.name)
        navigationItem.title = "Repository " + linkpullrequest.name
    }
  
    // MARK: -  Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pullmodel.pullrequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "Pullcell", for: indexPath) as? PullRequestListTableViewCell else{
            fatalError("Célula Não Encontrada")
        }
        let cellPullrequest = pullmodel.pullrequest[indexPath.row]
        cell.preparePullrequest(with: cellPullrequest)
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

}
extension PullRequestListViewController : PullRequestListModelDelegate {
    func updatePullRequest() {
        pullrequest += pullmodel.pullrequest
        DispatchQueue.main.async { [weak self] in
            self?.tableview.reloadData()
            self?.pullmodel.rechargeList = false
         }
    }
}
