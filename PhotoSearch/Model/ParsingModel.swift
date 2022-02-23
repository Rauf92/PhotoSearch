//
//  ParsingModel2.swift
//  PhotoSearch
//
//  Created by Rauf Aliyev on 16.02.22.
//

import Foundation
import UIKit

protocol parsingModelDelegate {
    func passData( data: [Results])
}

class ParsingModel {
    
    var delegate: parsingModelDelegate?
    
    func fetchData(searchKey: String) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&query=\(searchKey)&per_page=50&client_id=ffyNrSIbrT4ca4zapuQFk4SdIJsL4vbe_OeXC_ud_7k"
        
        guard let url = URL(string: urlString) else {return}
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, _, error in
            guard let retrievedData = data, error == nil else {return}
            guard let decodedData = self.jsonParsing(inputData: retrievedData) else {return}
            
            DispatchQueue.main.async {
                self.delegate?.passData(data: decodedData.results)
            }
        }
        task.resume()
    }
    
    func jsonParsing (inputData : Data) -> APIResponse? {
        let decoder = JSONDecoder()
        do {
            let data = try? decoder.decode(APIResponse.self, from: inputData)
            return data
        } catch {
            print("cannot get APIReponse from data")
            return nil
        }
    }
}

