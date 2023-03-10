//
//  JokeModel.swift
//  DontForget
//
//  Created by Rafał on 27/02/2023.
//

import Foundation

/*
 https://api.openweathermap.org/data/2.5/weather?q=Wroclaw&appid=IDIDIDIDID&units=metric
 
 {"coord":{"lon":17.0333,"lat":51.1},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"base":"stations","main":{"temp":-0.32,"feels_like":-2.9,"temp_min":-1.63,"temp_max":1.14,"pressure":1034,"humidity":78},"visibility":10000,"wind":{"speed":2.06,"deg":50},"clouds":{"all":0},"dt":1677526564,"sys":{"type":2,"id":2017463,"country":"PL","sunrise":1677476519,"sunset":1677515263},"timezone":3600,"id":3081368,"name":"Wrocław","cod":200}
 */

struct WeatherData: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}


