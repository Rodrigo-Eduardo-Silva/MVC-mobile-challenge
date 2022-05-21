import Foundation

protocol PullRequestListModelDelegate: AnyObject {
    func updatePullRequest()
}

class PullRequestListModel {
    var pullrequest: [PullRequest] = []
    weak var delegate: PullRequestListModelDelegate?
    let service: PullRequestListService
    var currentPage: Int
    var totalpullrequest: Int
    var rechargeList: Bool
    let pullOwner: GitRepository
    init(service: PullRequestListService = PullRequestListService()){
        self.service = service
        self.currentPage = 1
        totalpullrequest = 1
        rechargeList = false
    }
    
    func loadPullRequest(){
        rechargeList = true
        PullRequestListService().loadPullRequest(page: currentPage, owner: pullOwner.owner.login, repository: pullOwner.name) { pull in
            if let pull = pull {
                self.pullrequest += pull
                self.totalpullrequest = pull.count
            }
            self.delegate?.updatePullRequest()
        }
    }
}
