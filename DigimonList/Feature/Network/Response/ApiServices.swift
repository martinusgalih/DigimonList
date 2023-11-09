//
//  ApiServices.swift
//  DigimonList
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import Foundation
import Moya

class ApiServices {
    
    func getDigimonList(completion: @escaping (Result<[ReponseDigimonList], Error>) -> Void) {
        let provider = MoyaProvider<ApiRouter>()
        provider.request(.getList) { result in
            switch result {
            case let .success(response):
                do {
                    // Menggunakan Decodable untuk memetakan data response ke model
                    let digimons = try response.map([ReponseDigimonList].self)
                    completion(.success(digimons))
                } catch let error {
                    // Handle error jika pemetaan gagal
                    completion(.failure(error))
                }
            case let .failure(error):
                // Handle error request
                completion(.failure(error))
            }
        }
    }

}
