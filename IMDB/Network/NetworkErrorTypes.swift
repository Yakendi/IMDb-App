//
//  File.swift
//  IMDB
//
//  Created by Аслан Микалаев on 21.05.2023.
//

import Foundation

enum NetworkErrorTypes: Error {
    case invalidURL
    case emptyData
    case incorrectApiKey
    case nonHTTPResponse
    case error(error: Error)
}

extension NetworkErrorTypes: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Невалидный url адрес", comment: "Network error")
        case .emptyData:
            return NSLocalizedString("Данные не были получены", comment: "Decode error")
        case .incorrectApiKey:
            return NSLocalizedString("Используется недопустимый ключ API", comment: "Invalid APIKey")
        case .nonHTTPResponse:
            return NSLocalizedString("Ошибка сервера", comment: "HTTP Response error")
        case .error(let error):
            return NSLocalizedString("\(error.localizedDescription)", comment: "Error")
        }
    }
}
