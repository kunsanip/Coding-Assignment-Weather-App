//
//  RetrievingData.swift
//  Coding Assignment Weather App
//
//  Created by Sanip Shrestha on 2/23/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import Foundation
import SVProgressHUD


class RetrievingData{
    
    var cityTemp = [String:String]()
    var cityPressure = [String:String]()
    var cityHumidity = [String:String]()
    var cityVisibility = [String:String]()
    var cityMinTemp = [String:String]()
    var cityMaxTemp = [String:String]()
    var citySunrise = [String:String]()
    var citySunset = [String:String]()
    var cityWindSpeed = [String:String]()
    var cityWindDegree = [String:String]()
    var cityCloud = [String:String]()
    var cityWeatherDescription = [String:String]()
    
    
    var networkLoading: NetworkLoading = NetworkLoading()

    func retrieveData(citycode:Int){
        
//        UserDefaults.standard.removeObject(forKey: "Temperature")
//        
//        UserDefaults.standard.removeObject(forKey: "Pressure")
//        
//        UserDefaults.standard.removeObject(forKey: "Humidity")
//        
//        UserDefaults.standard.removeObject(forKey: "MinTemp")
//        
//        UserDefaults.standard.removeObject(forKey: "MaxTemp")
//        
//        UserDefaults.standard.removeObject(forKey: "Visibility")
//        
//        UserDefaults.standard.removeObject(forKey: "Sunrise")
//        
//        UserDefaults.standard.removeObject(forKey: "Sunset")
//        
//        UserDefaults.standard.removeObject(forKey: "WindSpeed")
//        
//        UserDefaults.standard.removeObject(forKey: "WindDegree")
//        
//        UserDefaults.standard.removeObject(forKey: "Cloud")
//        
//        UserDefaults.standard.removeObject(forKey:"WeatherDescription")
        // loading for some feedback to user while waiting for network response
        networkLoading.loading(string: "Loading..")
        
        DispatchQueue.global(qos: .background).async {
        
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(citycode)&units=metric&APPID=04ce859d9a8b9bdffe4cb50cf94b2633"){
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in //
                
                if error != nil {
                    
                    print(error!)
                    
                } else {
                    
                    if let urlContent = data {
                        
                        
                        do {
                            var cityTemp = ""
                            var cityPressure = ""
                            var cityHumidity = ""
                            var cityVisibility = ""
                            var cityMinTemp = ""
                            var cityMaxTemp = ""
                            var citySunrise = ""
                            var citySunset = ""
                            var cityWindSpeed = ""
                            var cityWindDegree = ""
                            var cityCloud = ""
                            var cityWeatherDescription = ""
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            var cityName = ""
                            if let name = (jsonResult["name"] as? String){
                            
                                cityName = name
                             }
                            if let main = (jsonResult["main"] as? NSDictionary){
                                
                                let temperature = String(describing: main["temp"] as! NSNumber)
                               
                                self.cityTemp[cityName] = temperature
                                
                                //
                                cityTemp = temperature
                                
                                UserDefaults.standard.set(self.cityTemp, forKey: "Temperature")
                                
                                
                            }
                            if let main = (jsonResult["main"] as? NSDictionary){
                                
                                //pressure
                                let pressure = String(describing: main["pressure"] as! NSNumber)
                                
                                 self.cityPressure[cityName] = pressure
                                
                                    cityPressure = pressure
                                UserDefaults.standard.set(self.cityPressure, forKey: "Pressure")
                                
                                //humidity
                                let humidity = String(describing: main["humidity"] as! NSNumber)
                                
                                self.cityHumidity[cityName] = humidity
                                cityHumidity = humidity

                               
                                UserDefaults.standard.set(self.cityHumidity, forKey: "Humidity")
                                
                                //minimum temperature
                                let minTemp = String(describing: main["temp_min"] as! NSNumber)
                                
                                self.cityMinTemp[cityName] = minTemp
                                cityMinTemp = minTemp

                               
                                UserDefaults.standard.set(self.cityMinTemp, forKey: "MinTemp")
                                
                                //maximum temperature
                                let maxTemp = String(describing: main["temp_max"] as! NSNumber)
                                
                                self.cityMaxTemp[cityName] = maxTemp
                                cityMaxTemp = maxTemp

                                
                                UserDefaults.standard.set(self.cityMaxTemp, forKey: "MaxTemp")
                                
                                
                                
                            }
                            
                            
                            //visibility
                            if let main = (jsonResult["visibility"] as? NSNumber){
                                
                                let visibility = String(describing: main)
                                self.cityVisibility[cityName] = visibility
                                cityVisibility = visibility
                                
                                UserDefaults.standard.set(self.cityVisibility, forKey: "Visibility")
                                
                                
                            }
                            
                            //sunrise
                            if let main = (jsonResult["sys"] as? NSDictionary){
                                
                                let sunrise = String(describing: main["sunrise"] as! NSNumber)
                                self.citySunrise[cityName] = sunrise
                                citySunrise = sunrise
                                
                                UserDefaults.standard.set(self.citySunrise, forKey: "Sunrise")
                                
                                
                            }
                            //sunset
                            if let main = (jsonResult["sys"] as? NSDictionary){
                                
                                let sunset = String(describing: main["sunset"] as! NSNumber)
                                self.citySunset[cityName] = sunset
                                citySunset = sunset
                                
                                UserDefaults.standard.set(self.citySunset, forKey: "Sunset")
                                
                                
                            }
                            
                            
                            //wind
                            if let main = (jsonResult["wind"] as? NSDictionary){
                                //wind Speed
                                let windSpeed = String(describing: main["speed"] as! NSNumber)
                                self.cityWindSpeed[cityName] = windSpeed
                                cityWindSpeed = windSpeed
                                UserDefaults.standard.set(self.cityWindSpeed, forKey: "WindSpeed")
                                
                                //wind Degree
                                if (main["deg"] as? NSNumber) != nil{
                                let windDegree = String(describing: main["deg"] as! NSNumber)
                                    self.cityWindDegree[cityName] = windDegree
                               cityWindDegree = windDegree
                                    UserDefaults.standard.set(self.cityWindDegree, forKey: "WindDegree")
                                }}
                            //cloud
                            if let main = (jsonResult["clouds"] as? NSDictionary){
                                
                                let cloud = String(describing: main["all"] as! NSNumber)
                                self.cityCloud[cityName] = cloud
                                cityCloud = cloud
                                UserDefaults.standard.set(self.cityCloud, forKey: "Cloud")
                                
                                
                            }
                            
                            //weatherDescription
                            if let main = (jsonResult["weather"] as? NSArray){
                                
                                var weather = String(describing: (main[0] as! NSDictionary)["description"] as! NSString )
                                //Capitalizing first letter
                                weather = weather.prefix(1).uppercased() + weather.lowercased().dropFirst()
                                self.cityWeatherDescription[cityName] = weather
                                cityWeatherDescription = weather
                                UserDefaults.standard.set(self.cityWeatherDescription, forKey: "WeatherDescription")
                                
                                
                            }
                            
                            
//                            let weatherInfo = [WeatherInfo]()
//                            let weatherObject = WeatherInfo(cityTemp: cityTemp, cityPressure: cityPressure, cityHumidity: cityHumidity, cityVisibility: cityVisibility, cityMinTemp: cityMinTemp, cityMaxTemp: cityMaxTemp, citySunrise: citySunrise, citySunset: citySunset, cityWindSpeed: cityWindSpeed, cityWindDegree: cityWindDegree, cityCloud: cityCloud, cityWeatherDescription: cityWeatherDescription)
//                            
//                            let weatherInfo1 = [WeatherInfo(cityTemp: "21", cityPressure: "21", cityHumidity: "21", cityVisibility: "21", cityMinTemp: "21", cityMaxTemp: "21", citySunrise: "21", citySunset: "21", cityWindSpeed: "21", cityWindDegree: "21", cityCloud: "21", cityWeatherDescription: "21"),WeatherInfo(cityTemp: "weatherinformation", cityPressure: "weatherinformation", cityHumidity: "weatherinformation", cityVisibility: "weatherinformation", cityMinTemp: "weatherinformation", cityMaxTemp: "weatherinformation", citySunrise: "weatherinformation", citySunset: "weatherinformation", cityWindSpeed: "weatherinformation", cityWindDegree: "weatherinformation", cityCloud: "weatherinformation", cityWeatherDescription: "weatherinformation")]
//                            
//                            var userDefaults = UserDefaults.standard
//                            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: weatherInfo)
//                            userDefaults.set(encodedData, forKey: "weatherInfo1")
//                            userDefaults.synchronize()
//                            
//                            let decoded  =  userDefaults.object(forKey: "weatherInfo1") as! Data
//                            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [WeatherInfo]
//                            for dec in decodedTeams{
//                                print(dec.cityCloud)
//                            }
                                
                            
                            
                            
                            
                            
                        } catch {
                            print("JSON Processing Failed")
                            
                        }
                    }
                    
                }
            }
            
            task.resume()
            
            }
            SVProgressHUD.dismiss()
            
        }
        
        
        
    }
}
