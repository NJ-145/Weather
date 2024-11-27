//
//  NetworkConstant.swift
//  Weather
//
//  Created by imac-2626 on 2024/11/21.
//

import Foundation

public enum NetworkPath {
    static let httpBaseUrl = "http://"
    static let httpsBaseUrl = "https://"
    
    static let serverAdress = "opendata.cwa.gov.tw/api"
    
    public enum ApiPath: String {
        case thirtySixHour = "/v1/rest/datastore/F-C0032-001"
    }
}
