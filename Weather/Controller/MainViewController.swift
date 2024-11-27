//
//  MainViewController.swift
//  Weather
//
//  Created by imac-2626 on 2024/11/21.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet var tbvWeather: UITableView!
    
    @IBOutlet var pkvCity: UIPickerView!
    
    // MARK: - Property
    
    var cities = [
        "臺北市", "新北市", "桃園市", "臺中市", "臺南市", "高雄市",
        "基隆市", "新竹市", "嘉義市", "新竹縣", "苗栗縣", "彰化縣",
        "南投縣", "雲林縣", "嘉義縣", "屏東縣", "宜蘭縣", "花蓮縣",
        "臺東縣", "澎湖縣", "金門縣", "連江縣"
    ]

    var displayData: [DisplayWeather] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
        setUi()
    }
    
    // MARK: - UI Settings
    func setUi() {
        tbvWeather.register(UINib(nibName: "TimeTableViewCell", bundle: nil), forCellReuseIdentifier: TimeTableViewCell.identifier)
        tbvWeather.delegate = self
        tbvWeather.dataSource = self
        pkvCity.delegate = self
        pkvCity.dataSource = self
    }
    
    // MARK: - IBAction
    
    // MARK: - Function
    
    func callAPI() {
        Task {
            do {
                let result: WeatherData = try await NetworkManager.shared.requestData(
                    method: .get,
                    path: .thirtySixHour,
                    parameters: WeatherRequest(
                        Authorization: "CWA-F5D61637-08A4-4204-8B6B-D1862709C762",
                        locationName: cities[0]
                    )
                )
                
                // 提取天氣資料
                let weatherElements = result.records.location.first?.weatherElement ?? []
                
                // 確保資料完整性
                guard
                    let wxTimes = weatherElements.first(where: { $0.elementName == "Wx" })?.time,
                    let popTimes = weatherElements.first(where: { $0.elementName == "PoP" })?.time,
                    let minTTimes = weatherElements.first(where: { $0.elementName == "MinT" })?.time,
                    let maxTTimes = weatherElements.first(where: { $0.elementName == "MaxT" })?.time,
                    let ciTimes = weatherElements.first(where: { $0.elementName == "CI" })?.time
                else {
                    print("資料不完整")
                    return
                }
                
                // 整理每段時間的資料到 DisplayWeather
                displayData = zip(wxTimes.indices, wxTimes).map { index, wxTime in
                    return DisplayWeather(
                        time: formatTimeRange(startTime: wxTime.startTime, endTime: wxTime.endTime), 
                        weather: wxTime.parameter.parameterName,
                        rainProbability: popTimes[index].parameter.parameterName,
                        temperature: "最低 \(minTTimes[index].parameter.parameterName)°C / 最高 \(maxTTimes[index].parameter.parameterName)°C",
                        comfort: ciTimes[index].parameter.parameterName
                    )
                }

                
                // 刷新 TableView
                DispatchQueue.main.async {
                    self.tbvWeather.reloadData()
                }
            } catch {
                print("API 錯誤: \(error.localizedDescription)")
            }
        }
    }

    func formatTimeRange(startTime: String, endTime: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // API 返回的時間格式
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MM/dd HH:mm" // 希望的顯示格式
        
        guard let startDate = inputFormatter.date(from: startTime),
              let endDate = inputFormatter.date(from: endTime) else {
            return "\(startTime) ~ \(endTime)" // 若格式不符，直接返回原始值
        }
        
        let formattedStart = outputFormatter.string(from: startDate)
        let formattedEnd = outputFormatter.string(from: endDate)
        return "\(formattedStart) ~ \(formattedEnd)"
    }

    
    
    //    func callAPI() {
    //        Task{
    //            let result: WeatherData = try await NetworkManager.shared.requestData(method: .get,
    //                                                                        path: .thirtySixHour,
    //                                                                        parameters: WeatherRequest(Authorization: "CWA-F5D61637-08A4-4204-8B6B-D1862709C762", locationName: city))
    //        }
    //    }
}
// MARK: - Extensions

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count // 時段的總數
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TimeTableViewCell.identifier, for: indexPath) as? TimeTableViewCell else {
            return UITableViewCell()
        }
        
        // 獲取對應的資料
        let weather = displayData[indexPath.row]
        
        // 配置 Cell 的內容
        cell.lbTime.text = weather.time
        cell.lbWeather.text = weather.weather
        cell.lbRain.text = "\(weather.rainProbability) %"
        cell.lbTemperature.text = weather.temperature
        cell.lbComfort.text = weather.comfort
        
        return cell
    }
}





extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 單欄 PickerView
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count // 縣市數量
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row] // 顯示縣市名稱
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 更新選擇的縣市並重新抓取資料
        cities[0] = cities[row]
        callAPI()
    }
}
