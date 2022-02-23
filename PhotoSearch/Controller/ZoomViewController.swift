//
//  IndividualViewController.swift
//  PhotoSearch
//
//  Created by Rauf Aliyev on 19.02.22.
//

import Foundation
import UIKit

class ZoomViewController: UIViewController {
    
    var imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
  
    func layout(){
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       
    }
}
