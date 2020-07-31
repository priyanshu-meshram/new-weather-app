
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=fc7734b59aa64de353f48eb6f3bc28a0&units=metric"
    
    var delegate: WeatherManagerDelegate?	
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        //starts the whole networking process
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1st create the url using URL object
        if let url = URL(string: urlString) {
            
            //2nd create session that acts as the controller like the browser
            let session = URLSession(configuration: .default)
            
            //3rd give the session a task 
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data { //if data exits
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            let temp_main = decodedData.main.temp_min
            let temp_max = decodedData.main.temp_max
            let humidity = decodedData.main.humidity
            let feels_like = decodedData.main.feels_like
            let windSpeed = decodedData.wind.speed
            let visibilty = decodedData.visibility
            let weather = WeatherModel(description: description, humidity: humidity, feels_like: feels_like, windSpeed: windSpeed, visibility: visibilty, temp_min: temp_main, temp_max: temp_max, conditionId: id, cityName : name, temperature : temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}


