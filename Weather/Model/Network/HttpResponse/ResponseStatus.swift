//
//  ResponseStatus.swift
//  Weather
//
//  Created by imac-2626 on 2024/11/21.
//

import Foundation

public enum ResponseStatus: Error {
    case unknownError(Error)
    
    case connectionError
    
    case invalidResponse
    
    case jsonDecodeFailed(DecodingError)
    
    case invalidURLRequest
    
    case authorizationError
    
    case notFound
    
    case internalError
    
    case serverError
    
    case severUnavailable
    
    case badRequest
    
    case badGateway
}
