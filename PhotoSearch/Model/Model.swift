//
//  Model.swift
//  PhotoSearch
//
//  Created by Rauf Aliyev on 19.02.22.
//

import Foundation
import UIKit


class Model {
    
    func getImage( with urlString: String, completion: @escaping(UIImage?)-> Void) {
        guard
            let url = URL(string: urlString) else {
            completion(nil)
            return}
            let session = URLSession.shared
            let task = session.dataTask(with: url) { [weak self] data, _, error in
                guard
                      let newData = data, error == nil else {return}
                DispatchQueue.main.async {
                    completion(UIImage(data: newData))
                }
            }
            task.resume()    
    }
}

