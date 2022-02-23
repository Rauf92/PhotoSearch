//
//  Objects.swift
//  PhotoSearch
//
//  Created by Rauf Aliyev on 16.02.22.
//

import Foundation
import UIKit


struct APIResponse: Codable {
    let total : Int
    let total_pages : Int
    let results: [Results]
}

struct Results: Codable {
    let id : String
    let urls: URLS
}

struct URLS: Codable {
    
    let regular : String
}
