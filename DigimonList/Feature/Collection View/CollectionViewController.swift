//
//  CollectionViewController.swift
//  DigimonList
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

class CollectionViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8.0
        layout.minimumLineSpacing = 8.0
        let cellWidth = (view.frame.width - 3 * layout.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var searchTextfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Search"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderWidth = 0.5
        text.layer.cornerRadius = 4
        text.layer.borderColor = UIColor.lightGray.cgColor
        return text
    }()
    
    let viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidLoad()
        setupCollectionView()
        bind()
        setupView()
    }
    
    func bind() {
        viewModel.didRefresh = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func setupView() {
        title = "Digimon Collection List"
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(searchTextfield)
        
        NSLayoutConstraint.activate([
            searchTextfield.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0),
            searchTextfield.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
            searchTextfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
            
            collectionView.topAnchor.constraint(equalTo: searchTextfield.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        searchTextfield.delegate = self
    }
    
    func setupCollectionView() {
        collectionView.register(UINib(nibName: CollectionViewCell.className(), bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.className())
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.digimonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.className(), for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        let item = viewModel.digimonList[indexPath.row]
        cell.setItem(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let cellWidth = (collectionView.frame.width - 3 * 8.0) / 2
          return CGSize(width: cellWidth, height: cellWidth)
      }
}

extension CollectionViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.digimonList = (textField.text?.isEmpty ?? true) ? viewModel.defaultDigimonList :  viewModel.defaultDigimonList.filter { digimon in
            return digimon.name.lowercased().contains(textField.text?.lowercased() ?? "")
        }
        
        collectionView.reloadData()
    }
}
