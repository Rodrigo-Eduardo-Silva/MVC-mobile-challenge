import Foundation

struct Owner: Codable{
    let login: String
    let id: Int
    let avatar_url: String
    let repos_url: String
}

extension Owner{
    static func fixture(
        login: String = "Rodries",
        id: Int = 778,
        avatar_url: String = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1",
        repos_url: String = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1"
    ) -> Owner {
        Owner(login: login, id: id, avatar_url: avatar_url, repos_url: repos_url)
    }
}
