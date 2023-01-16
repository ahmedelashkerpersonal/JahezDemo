//
//  NetworkError.swift
//  JahezDemo
//
//  Created by Ahmed Elashker on 17/01/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case invalidData
    
    var title: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("URL Error", comment: "")
        case .invalidServerResponse:
            return NSLocalizedString("Server Error", comment: "")
        case .invalidData:
            return NSLocalizedString("Data Error", comment: "")
        }
    }
    
    var message: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The entered url is not in the correct format.", comment: "")
        case .invalidServerResponse:
            return NSLocalizedString("We are facing technical issues at this moment, please try again later.", comment: "")
        case .invalidData:
            return NSLocalizedString("We have a problem loading data at this moment, please try again later.", comment: "")
        }
    }
}
