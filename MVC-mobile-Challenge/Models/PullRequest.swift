import Foundation
struct Pull : Codable {
var pullRequest : [PullRequest]
}

struct PullRequest : Codable {
    var title : String
    var user : User
}
