//
//  RespositoriesListService.swift
//  MVC-mobile-Challenge
//
//  Created by Rodrigo Eduardo Silva on 09/05/22.
//

import Foundation


class RepositoriesListService {
    
    static private let basePath = "https://api.github.com/search/repositories?"
    static private let privateToken = "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"
    static private let teste = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1"
    static private let per_page = 50
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization": "\(privateToken)","Accept": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        return config
    }()
    private static let session = URLSession(configuration: configuration)
        
    class func LoadRepositories(completion: @escaping (GitHead?) -> Void){
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
