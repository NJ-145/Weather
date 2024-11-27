//
//  EnCodeable+JsonToDict.swift
//  Weather
//
//  Created by imac-2626 on 2024/11/21.
//

import Foundation

extension Encodable {
    //將 Encodable 物件轉換為字典
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self) // 編碼為 JSON
        guard let dicationary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            
            throw NSError() // 轉換為字典
        }
        return dicationary
    }
}
