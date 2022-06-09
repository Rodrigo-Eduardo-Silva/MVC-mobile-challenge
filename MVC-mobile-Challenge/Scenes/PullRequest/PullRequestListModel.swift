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
    
    init(service: PullRequestListService) {
        self.service = service
        self.currentPage = 1
        totalpullrequest = 1
        rechargeList = false
    }
    
    func loadPullRequest(owner: String ,repository: String){
        rechargeList = true
            service.loadPullRequest(page: currentPage, owner: owner, repository: repository) { pull in
                if let pull = pull {
                    self.pullrequest += pull
                    self.totalpullrequest = pull.count
                }
                self.delegate?.updatePullRequest()
            }
    }
}

class PullRequestListModelMock: PullRequestListModel {
    
    override func loadPullRequest(owner: String ,repository: String) {
        self.pullrequest = [
            PullRequest.init(title: "teste", user: User.init(avatar_url: "", body: "something", html_url: "")),
            PullRequest.init(title: "teste", user: User.init(avatar_url: "", body: "something", html_url: "")),
            PullRequest.init(title: "teste", user: User.init(avatar_url: "", body: "something", html_url: ""))
        ]
        delegate?.updatePullRequest()
    }
}
