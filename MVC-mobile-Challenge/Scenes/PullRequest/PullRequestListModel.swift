import Foundation

class PullRequestListModel {
    var pullrequest: [PullRequest] =  []
    let service: PullRequestListService
    var currentPage: Int
    var totalpullrequest: Int
    var rechargeList: Bool
    let pullOwner: Owner
    let pullname: GitRepository
    init(service: PullRequestListService = PullRequestListService()){
        self.service = service
        self.currentPage = 1
        totalpullrequest = 1
        rechargeList = false
        pullOwner
    }
    func loadPullRequest(){
        rechargeList = true
        PullRequestListService().loadPullRequest(page: currentPage, owner: pullOwner.login, repository: pullname.name) { pull in
            if let pull = pull {
                self.pullrequest += pull
                self.totalpullrequest = pull.count
            }
        }
    }
}
