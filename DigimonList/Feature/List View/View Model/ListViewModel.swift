//
//  ListViewModel.swift
//  DigimonList
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import Foundation

class ListViewModel {
    let apiServices = ApiServices()
    var digimonList: [ReponseDigimonList] = []
    var defaultDigimonList: [ReponseDigimonList] = []
    var didRefresh: (() -> Void)? = nil
    
    func onViewDidLoad() {
        getDigimon()
    }
    
    func getDigimon() {
        apiServices.getDigimonList { [weak self] (response) in
            switch response {
              case let .success(digimons):
                    self?.digimonList = digimons
                    self?.defaultDigimonList = digimons
                    self?.didRefresh?()
              case let .failure(error):
                  print(error)
              }
        }
    }
}
