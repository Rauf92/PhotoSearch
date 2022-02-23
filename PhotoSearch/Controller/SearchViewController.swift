//
//  ViewController.swift
//  PhotoSearch
//
//  Created by Rauf Aliyev on 16.02.22.
//

import UIKit

class SearchViewController: UIViewController, parsingModelDelegate {
    
    
    
    let cvCellID = "cvCell"
    var results : [Results] = []
    let searchController = UISearchController(searchResultsController: nil)
 
    
   lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: cvCellID)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
  
    let parsingModel = ParsingModel()
    let model = Model()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        parsingModel.delegate = self
        searchController.searchBar.delegate = self
        cvLayout()
    }
    
    func cvLayout() {
        navigationItem.searchController = searchController
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cvCellID, for: indexPath) as! ImageCollectionViewCell
        let imageLink = results[indexPath.item].urls.regular
        cell.loadImage(with: imageLink)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height/4)
    }
    
    func passData(data: [Results]) {
        results = data
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        parsingModel.fetchData(searchKey: searchText)
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ZoomViewController()
        navigationController?.present(vc, animated: true)
        model.getImage(with: results[indexPath.item].urls.regular) { image in
            vc.imageView.image = image
        }
    }
}
