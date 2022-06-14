import UIKit

class PullRequestListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    var pullrequest: [PullRequest] = []
    var pullmodel: PullRequestListModel?
    var linkpullrequest: GitRepository!
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Carregando Pulls Request"
        tableview.dataSource = self
        tableview.delegate = self
        pullmodel?.delegate = self
        pullmodel?.loadPullRequest(owner: linkpullrequest.owner.login, repository: linkpullrequest.name)
       // navigationItem.title = "Repository " + linkpullrequest.name
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PullRequestListViewControllerWeb
        let pullrequest = pullmodel?.pullrequest[tableview.indexPathForSelectedRow!.row]
        vc.pullrequestWeb = pullrequest
    }
  
    // MARK: -  Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pullmodel?.pullrequest.count == 0 {
            tableView.backgroundView = label
        }
       // tableView.backgroundView = pullmodel.pullrequest.count == 0 ? label : nil
        return pullmodel?.pullrequest.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "Pullcell", for: indexPath) as? PullRequestListTableViewCell else{
            fatalError("Célula Não Encontrada")
        }
        guard let cellPullrequest = pullmodel?.pullrequest[indexPath.row] else{
            fatalError()
        }
        
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let pullmodel = pullmodel else {
            return
        }

        if indexPath.row == pullmodel.pullrequest.count - 20 && !pullmodel.rechargeList && pullmodel.pullrequest.count != pullmodel.totalpullrequest {
            pullmodel.currentPage += 1
            pullmodel.loadPullRequest(owner: linkpullrequest.owner.login, repository: linkpullrequest.name)
        }
    }
}
extension PullRequestListViewController : PullRequestListModelDelegate {
    func updatePullRequest() {
        guard let pullmodel = pullmodel else {
            return
        }
        pullrequest += pullmodel.pullrequest
        DispatchQueue.main.async { [weak self] in
            self?.tableview.reloadData()
            self?.pullmodel?.rechargeList = false
            self?.label.text = " Não Existem Pull Request para esse repositório"
         }
    }
}
