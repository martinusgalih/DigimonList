//
//  ApiRouter.swift
//  DigimonList
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import Moya

enum ApiRouter {
    case getList
}

extension ApiRouter: TargetType {
    var baseURL: URL {
        return URL(string: "https://digimon-api.vercel.app/api")!
    }

    var path: String {
        switch self {
        case .getList:
            return "/digimon"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getList:
            return .get
        }
    }

    var sampleData: Data {
        return Data() // Anda bisa menyediakan data sampel jika diperlukan
    }

    var task: Task {
        switch self {
        case .getList:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var validationType: ValidationType {
         return .successCodes
     }
}
