//
//  MainViewController.swift
//  DigimonList
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var mainContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var buttonList: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = .red
        button.setTitle("Table View", for: .normal)
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonCollection: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = .blue
        button.setTitle("Collection View", for: .normal)
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
            case 0:
                self.navigationController?.present(ListViewController(), animated: true)
            case 1:
                self.navigationController?.present(CollectionViewController(), animated: true)
            default:
                break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension MainViewController {
    func setupView() {
        view.addSubview(container)
        container.addArrangedSubview(mainContainer)
        
        mainContainer.addArrangedSubview(buttonList)
        mainContainer.addArrangedSubview(buttonCollection)
        
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.rightAnchor.constraint(equalTo: view.rightAnchor),
            container.leftAnchor.constraint(equalTo: view.leftAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
