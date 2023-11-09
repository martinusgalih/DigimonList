//
//  ListViewController.swift
//  DigimonList
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var searchTextfield: UITextField! {
        didSet {
            searchTextfield.placeholder = "Search"
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
        viewModel.onViewDidLoad()
        bind()
    }
    
    func bind() {
        viewModel.didRefresh = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func setupView() {
        title = "Digimon List"
        searchTextfield.delegate = self
    }

    func setupTableView() {
        tableView.register(UINib(nibName: ListViewCell.className(), bundle: nil), forCellReuseIdentifier: ListViewCell.className())
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.digimonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.className(), for: indexPath) as? ListViewCell else { return UITableViewCell() }
        let item = viewModel.digimonList[indexPath.row]
        cell.setItem(item: item)
        return cell
    }
    
    
}

extension ListViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.digimonList = (textField.text?.isEmpty ?? true) ? viewModel.defaultDigimonList :  viewModel.defaultDigimonList.filter { digimon in
            return digimon.name.lowercased().contains(textField.text?.lowercased() ?? "")
        }
        
        tableView.reloadData()
    }
}
