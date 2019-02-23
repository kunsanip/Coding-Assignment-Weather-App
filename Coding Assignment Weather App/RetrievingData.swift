//
//  RetrievingData.swift
//  Coding Assignment Weather App
//
//  Created by Sanip Shrestha on 2/23/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import Foundation
class RetrievingData{
    
    var cityTemp = [String]()
    var cityPressure = [String]()
    var cityHumidity = [String]()
    var cityVisibility = [String]()
    var cityMinTemp = [String]()
    var cityMaxTemp = [String]()
    var citySunrise = [String]()
    var citySunset = [String]()
    var cityWindSpeed = [String]()
    var cityWindDegree = [String]()
    var cityCloud = [String]()
    var cityWeatherDescription = [String]()
    
    
    
    func retrievingData(citycode:Int){
        
        
        
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(citycode)&units=metric&APPID=04ce859d9a8b9bdffe4cb50cf94b2633"){
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in //
                
                if error != nil {
                    
                    print(error!)
                    
                } else {
                    
                    if let urlContent = data {
                        
                        
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            /*if let name = (jsonResult["name"] as? String){
                             self.weatherReport.append(name)
                             UserDefaults.standard.set(name, forKey: name)
                             
                             }*/
                            if let main = (jsonResult["main"] as? NSDictionary){
                                
                                let temperature = String(describing: main["temp"] as! NSNumber)
                                self.cityTemp.append(temperature)
                                
                                UserDefaults.standard.set(self.cityTemp, forKey: "Temperature")
                                
                                
                            }
                            if let main = (jsonResult["main"] as? NSDictionary){
                                
                                //pressure
                                let pressure = String(describing: main["pressure"] as! NSNumber)
                                
                                self.cityPressure.append(pressure)
                                UserDefaults.standard.set(self.cityPressure, forKey: "Pressure")
                                
                                //humidity
                                let humidity = String(describing: main["humidity"] as! NSNumber)
                                
                                self.cityHumidity.append(humidity)
                                
                                UserDefaults.standard.set(self.cityHumidity, forKey: "Humidity")
                                
                                //minimum temperature
                                let minTemp = String(describing: main["temp_min"] as! NSNumber)
                                
                                self.cityMinTemp.append(minTemp)
                                
                                UserDefaults.standard.set(self.cityMinTemp, forKey: "MinTemp")
                                
                                //maximum temperature
                                let maxTemp = String(describing: main["temp_max"] as! NSNumber)
                                
                                self.cityMaxTemp.append(maxTemp)
                                
                                UserDefaults.standard.set(self.cityMaxTemp, forKey: "MaxTemp")
                                
                                
                                
                            }
                            
                            
                            //visibility
                            if let main = (jsonResult["visibility"] as? NSNumber){
                                
                                let visibility = String(describing: main)
                                self.cityVisibility.append(visibility)
                                
                                UserDefaults.standard.set(self.cityVisibility, forKey: "Visibility")
                                
                                
                            }
                            
                            //sunrise
                            if let main = (jsonResult["sys"] as? NSDictionary){
                                
                                let sunrise = String(describing: main["sunrise"] as! NSNumber)
                                self.citySunrise.append(sunrise)
                                
                                UserDefaults.standard.set(self.citySunrise, forKey: "Sunrise")
                                
                                
                            }
                            //sunset
                            if let main = (jsonResult["sys"] as? NSDictionary){
                                
                                let sunset = String(describing: main["sunset"] as! NSNumber)
                                self.citySunset.append(sunset)
                                
                                UserDefaults.standard.set(self.citySunset, forKey: "Sunset")
                                
                                
                            }
                            
                            
                            //wind
                            if let main = (jsonResult["wind"] as? NSDictionary){
                                //wind Speed
                                let windSpeed = String(describing: main["speed"] as! NSNumber)
                                self.cityWindSpeed.append(windSpeed)
                                UserDefaults.standard.set(self.cityWindSpeed, forKey: "WindSpeed")
                                
                                //wind Degree
                                let windDegree = String(describing: main["deg"] as! NSNumber)
                                self.cityWindDegree.append(windDegree)
                                UserDefaults.standard.set(self.cityWindDegree, forKey: "WindDegree")
                            }
                            //cloud
                            if let main = (jsonResult["clouds"] as? NSDictionary){
                                
                                let cloud = String(describing: main["all"] as! NSNumber)
                                self.cityCloud.append(cloud)
                                UserDefaults.standard.set(self.cityCloud, forKey: "Cloud")
                                
                                
                            }
                            
                            //weatherDescription
                            if let main = (jsonResult["weather"] as? NSArray){
                                
                                var weather = String(describing: (main[0] as! NSDictionary)["description"] as! NSString )
                                //Capitalizing first letter
                                weather = weather.prefix(1).uppercased() + weather.lowercased().dropFirst()
                                self.cityWeatherDescription.append(weather)
                                UserDefaults.standard.set(self.cityWeatherDescription, forKey: "WeatherDescription")
                                
                                
                            }
                            
                            
                            
                        } catch {
                            print("JSON Processing Failed")
                            
                        }
                    }
                    
                }
            }
            
            task.resume()
            
        }
        
        
        
    }
}
