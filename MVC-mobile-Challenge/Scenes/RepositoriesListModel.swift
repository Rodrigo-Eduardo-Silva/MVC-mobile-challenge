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
    var repositories: [GitRepository] = []
    var service: RepositoriesListService!
    weak var delegate : RepositoriesListModelDelegate?

    func loadRepositories(){
        RepositoriesListService.LoadRepositories { [weak self] repository in
           if let repository = repository {
                self?.repositories += repository.items
          }
            self?.delegate?.updateRepositoriesModel()
        }
    }
    
}



