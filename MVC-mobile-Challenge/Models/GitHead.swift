//
//  Github.swift
//  MVC-mobile-Challenge
//
//  Created by dede.exe on 16/05/22.
//

import Foundation

struct GitHead: Codable {
    let total_count: Int
    let items: [GitRepository]
}
