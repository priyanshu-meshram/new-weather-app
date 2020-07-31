
import Foundation

struct WeatherModel {
    let description : String
    let humidity : Int
    let feels_like : Double
    let windSpeed : Double
    let visibility : Int
    let temp_min : Double
    let temp_max : Double
    let conditionId: Int
    let cityName: String
    let temperature: Double
    var windSpeedString : String{
        return String(format: "%.1f", windSpeed)
    }
    var feelsLikeString : String{
        return String(format: "%.1f", feels_like)
    }
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var tempMinString : String {
        return String(format: "%.1f", temp_min)
    }
    var tempMaxString : String {
        return String(format: "%.1f", temp_max)
    }
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
