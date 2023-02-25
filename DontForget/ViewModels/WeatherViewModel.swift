//
//  JokesViewModel.swift
//  DontForget
//
//  Created by Rafał on 27/02/2023.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    
    @Published var weatherData: WeatherData?
    
    var cancellables = Set<AnyCancellable>()
    
    init(){
        getWeatherURLSession()
    }
    
    
    
    func getWeatherURLSession(){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Wroclaw&appid=4b0536fd89158be8ef07e9642d78dd5e&units=metric") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    self.weatherData = weatherData
                }
            } catch let error {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
    func getWeatherCombine(){
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Wroclaw&appid=4b0536fd89158be8ef07e9642d78dd5e&units=metric") else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                print("Data: \(data)")
                return data
            }
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .sink { completion in
                print("Download completed \(completion)")
            } receiveValue: { [weak self] returnedValue in
                self?.weatherData = returnedValue
                print("result: \(returnedValue)")
            }
            .store(in: &cancellables)
        
    }
    
    
    func getTemperature() -> String{
        if let temperature = weatherData?.main.temp {
            return("\(temperature)°C")
        }
        return "???"
    }
    
    func getWeather() -> String{
        if let weather = weatherData?.weather[0].main.description {
            return("\(weather)")
        }
        return ""
    }
    
    func getWeatherIconName() -> String{
        if let weather = weatherData?.weather[0].icon {
            return("\(weather)")
        }
        return ""
    }
    
    
    /*
     If data weather discription is more ->
     
     if let weather = weatherData?.weather {
     let weatherDescriptions = weather.map { $0.main.description }
     return weatherDescriptions.joined(separator: ", ")
     }
     
     */
    
}
