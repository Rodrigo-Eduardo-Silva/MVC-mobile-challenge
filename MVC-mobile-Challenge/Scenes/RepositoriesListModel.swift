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
    weak var delegate : RepositoriesListModelDelegate?
    let service: RepositoriesListService

    init(service: RepositoriesListService = RepositoriesListService()) {
        self.service = service
    }

    func loadRepositories(){
        RepositoriesListService().loadRepositories { [weak self] repository in
           if let repository = repository {
                self?.repositories += repository.items
          }
            self?.delegate?.updateRepositoriesModel()
        }
    }
    
}



