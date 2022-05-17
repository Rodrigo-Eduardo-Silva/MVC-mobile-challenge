//
//  RespositoriesListService.swift
//  MVC-mobile-Challenge
//
//  Created by Rodrigo Eduardo Silva on 09/05/22.
//

import Foundation


class RepositoriesListService {
    
    private let basePath = "https://api.github.com/search/repositories?"
    private let privateToken = "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"
    private let teste = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1"
    private let per_page = 50

    private let session: URLSession

    init() {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization": "\(privateToken)","Accept": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        session = URLSession(configuration: config)
    }
        
    func loadRepositories(completion: @escaping (GitHead?) -> Void){
        guard let url = URL(string: teste) else {return}
        let dataTask = session.dataTask(with: url) { data, response, error in
            if error == nil{
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200{
                    guard let data = data else {return}
                    do {
                        let repositories = try JSONDecoder().decode(GitHead.self, from: data)
                        completion(repositories)
                    }catch{
                        print(error.localizedDescription)
                        print("Json error")
                    }
                } else {
                    print("Problema no servidor")
                }
            } else {
                print(error as Any)
            }
        }
        dataTask.resume()
    }

}
