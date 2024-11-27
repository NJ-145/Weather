//
//  WeatherData.swift
//  Weather
//
//  Created by imac-2626 on 2024/11/21.
//

import Foundation


struct WeatherRequest: Encodable {
    var Authorization: String
    var locationName: String
}

struct WeatherData: Codable {
    var success: String
    var result: ResultValue
    var records: RecordsValue
}



struct ResultValue: Codable {
    var resource_id: String
    var fields: [FieldsValue]
}

struct RecordsValue: Codable {
    var datasetDescription: String
    var location: [LocationValue]
}

struct FieldsValue: Codable {
    var id: String
    var type: String
}

struct LocationValue: Codable {
    var locationName: String
    var weatherElement: [WeatherElementValue]
}

struct WeatherElementValue: Codable {
    var elementName: String
    var time: [TimeValue]
}

struct TimeValue: Codable {
    var startTime: String
    var endTime: String
    var parameter: ParameterValue
}

struct ParameterValue: Codable {
    var parameterName: String
    var parameterValue: String?
    var parameterUnit: String?
}

// DisplayWeather: 用於界面顯示的資料
struct DisplayWeather {
    let time: String
    let weather: String
    let rainProbability: String
    let temperature: String
    let comfort: String
}
