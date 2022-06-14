import Foundation

struct GitRepository: Codable {
    let id: Int
    let name: String
    let full_name: String
    let stargazers_count: Int
    let forks: Int
    let description: String?
    let owner: Owner
}

extension GitRepository {
    static func fixture(
        id: Int = 100,
        name: String = "Rodrigo",
        full_name: String = "SivaInfo",
        stargazers_count: Int = 10,
        forks: Int  = 33,
        description: String? = "teste fix",
        owner: Owner = Owner.fixture()
    ) -> GitRepository {
        GitRepository(id: id, name: name, full_name: full_name, stargazers_count: stargazers_count, forks: forks, description: description, owner: owner)
    }
}
