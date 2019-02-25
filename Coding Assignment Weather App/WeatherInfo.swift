//
//  WeatherInfo.swift
//  Coding Assignment Weather App
//
//  Created by Sanip Shrestha on 2/26/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import Foundation

class WeatherInfo: NSObject, NSCoding {
    var cityTemp : String
    var cityPressure : String
    var cityHumidity : String
    var cityVisibility : String
    var cityMinTemp : String
    var cityMaxTemp : String
    var citySunrise : String
    var citySunset : String
    var cityWindSpeed : String
    var cityWindDegree : String
    var cityCloud : String
    var cityWeatherDescription : String
    
    
    
    init(cityTemp : String, cityPressure : String, cityHumidity : String,cityVisibility : String,cityMinTemp : String,cityMaxTemp : String, citySunrise : String, citySunset : String, cityWindSpeed : String, cityWindDegree : String, cityCloud : String, cityWeatherDescription : String){
        
        self.cityTemp = cityTemp
        self.cityPressure = cityPressure
        self.cityHumidity = cityHumidity
        self.cityVisibility = cityVisibility
        self.cityMinTemp = cityMinTemp
        self.cityMaxTemp = cityMaxTemp
        self.citySunrise = citySunrise
        self.citySunset = citySunset
        self.cityWindSpeed = cityWindSpeed
        self.cityWindDegree = cityWindDegree
        self.cityCloud = cityCloud
        self.cityWeatherDescription = cityWeatherDescription
        
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        
        let cityTemp = aDecoder.decodeObject(forKey: "cityTemp") as! String
        let cityPressure = aDecoder.decodeObject(forKey: "cityPressure") as! String
        let cityHumidity = aDecoder.decodeObject(forKey: "cityHumidity") as! String
        let cityVisibility = aDecoder.decodeObject(forKey:"cityVisibility") as! String
        let cityMinTemp = aDecoder.decodeObject(forKey:"cityMinTemp") as! String
        let cityMaxTemp = aDecoder.decodeObject(forKey:"cityMaxTemp") as! String
        let citySunrise = aDecoder.decodeObject(forKey:"citySunrise") as! String
        let citySunset = aDecoder.decodeObject(forKey:"citySunset") as! String
        let cityWindSpeed = aDecoder.decodeObject(forKey:"cityWindSpeed") as! String
        let cityWindDegree = aDecoder.decodeObject(forKey:"cityWindDegree") as! String
        let cityCloud = aDecoder.decodeObject(forKey:"cityCloud") as! String
        let cityWeatherDescription = aDecoder.decodeObject(forKey:"cityWeatherDescription") as! String
        
        self.init(cityTemp: cityTemp, cityPressure: cityPressure, cityHumidity: cityHumidity, cityVisibility: cityVisibility, cityMinTemp: cityMinTemp, cityMaxTemp: cityMaxTemp, citySunrise: citySunrise, citySunset: citySunset, cityWindSpeed: cityWindSpeed, cityWindDegree: cityWindDegree, cityCloud: cityCloud, cityWeatherDescription: cityWeatherDescription)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(cityTemp, forKey: "cityTemp")
        aCoder.encode(cityPressure, forKey: "cityPressure")
        aCoder.encode(cityHumidity, forKey: "cityHumidity")
        aCoder.encode(cityVisibility, forKey: "cityVisibility")
        aCoder.encode(cityMinTemp, forKey: "cityMinTemp")
        aCoder.encode(cityMaxTemp, forKey: "cityMaxTemp")
        aCoder.encode(citySunrise, forKey: "citySunrise")
        aCoder.encode(citySunset, forKey: "citySunset")
        aCoder.encode(cityWindSpeed, forKey: "cityWindSpeed")
        aCoder.encode(cityWindDegree, forKey: "cityWindDegree")
        aCoder.encode(cityCloud, forKey: "cityCloud")
        aCoder.encode(cityWeatherDescription, forKey: "cityWeatherDescription")
        
        
    }
}
