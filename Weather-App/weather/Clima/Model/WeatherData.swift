
import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let visibility : Int
    let wind : Wind
}
struct Wind : Codable {
    let speed : Double
}
struct Main: Codable {
    let temp: Double
    let temp_min : Double
    let temp_max : Double
    let pressure : Int
    let humidity : Int
    let feels_like : Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
