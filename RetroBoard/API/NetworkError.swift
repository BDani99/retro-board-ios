//
//  NetworkError.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 15..
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}
