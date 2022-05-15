//
//  RepositoriesListModel.swift
//  MVC-mobile-Challenge
//
//  Created by Rodrigo Eduardo Silva on 09/05/22.
//

import Foundation

protocol RepositoriesListModelDelegate : AnyObject{
    func updateRepositoriesModel()
}

class RepositoriesListModel {
    var repositories: [GitRepositories] = []
    var service: RepositoriesListService!
    weak var delegate : RepositoriesListModelDelegate?
    

    struct GitHead : Codable {
        let total_count : Int
        let items : [GitRepositories]
    }

    struct GitRepositories : Codable{
        let id : Int
        let name: String
        let full_name: String
        let stargazers_count : Int
        let forks: Int
        let description: String?
        let owner : Owner
    }

    struct Owner : Codable{
        let login : String
        let id : Int
        let avatar_url : String
        let repos_url : String
    }
    
    func loadRepositories(){
        RepositoriesListService.LoadRepositories { [weak self] repository in
           if let repository = repository {
                self?.repositories += repository.items
          }
            self?.delegate?.updateRepositoriesModel()
        }
    }
    
}



