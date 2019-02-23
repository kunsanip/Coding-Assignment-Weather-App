//
//  ViewController.swift
//  Coding Assignment Weather App
//
//  Created by Sanip Shrestha on 2/11/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import UIKit
import SVProgressHUD
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var newCityCode:String = ""
    var newCity:String = ""
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
    
    @IBOutlet weak var messageLabel: UILabel!
    var cities = ["Sydney","Brisbane","Melbourne"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*  let sydneycode = 4163971
         let melbournecode = 2147714
         let brisbanecode = 2174003*/
        Loading(string: "Loading..")
        DispatchQueue.global(qos: .background).async {
        self.retrievingData(citycode: 4163971)
        self.retrievingData(citycode: 2147714)
        self.retrievingData(citycode: 2174003)
            if self.newCity != "" {
                self.cities.append(self.newCity)
                self.retrievingData(citycode: Int(self.newCityCode)!)
            }

            
        SVProgressHUD.dismiss()
        }
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cities.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        
    {
        //        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.city.text! = cities[indexPath.row]
        
        let arrayObject = UserDefaults.standard.object(forKey: "Temperature")
        
        if let array = arrayObject as? NSArray{
            let avgtemp = (array[indexPath.row]) as! String
            cell.avgTemp.text! = avgtemp as! String + "°"
            
            
            
        }
        
        
        
        return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130 
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        var weatherDescription = ""
        var pressure = ""
        var humidity = ""
        var visibility = ""
        var minimumTemp = ""
        var maximumTemp = ""
        var sunrise = ""
        var sunset = ""
        var windSpeed = ""
        var windDegree = ""
        var cloud = ""
        var weather = ""
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController
        vc?.citytext = cities[indexPath.row]
        
        let arrayObjectTemperature = UserDefaults.standard.object(forKey: "Temperature")
        if let array = arrayObjectTemperature as? NSArray{
            let avgtemp = (array[indexPath.row]) as! String
            vc?.temperature = avgtemp + "°"
            
            
        }
        //Weather Description
        let arrayObjectWeather =  UserDefaults.standard.object(forKey: "WeatherDescription")

        if let array = arrayObjectWeather as? NSArray{
            weatherDescription = (array[indexPath.row]) as! String
            
        }
        
        
        //Pressure
        let arrayObjectPressure = UserDefaults.standard.object(forKey: "Pressure")
        if let array = arrayObjectPressure as? NSArray{
            pressure = (array[indexPath.row]) as! String
            
        }
        //Humidity
        let arrayObjectHumidity = UserDefaults.standard.object(forKey: "Humidity")
        if let array = arrayObjectHumidity as? NSArray{
            humidity = (array[indexPath.row]) as! String
            
        }
        //visibility
        
        
        let arrayObjectVisibility = UserDefaults.standard.object(forKey: "Visibility")
        if let array = arrayObjectVisibility as? NSArray{
            visibility = (array[indexPath.row]) as! String
        }
        
        
        
        //minimum temperature
        let arrayObjectMinTemp = UserDefaults.standard.object(forKey: "MinTemp")
        if let array = arrayObjectMinTemp as? NSArray{
            minimumTemp = (array[indexPath.row]) as! String
        }
        //maximum temperature
        let arrayObjectMaxTemp = UserDefaults.standard.object(forKey: "MaxTemp")
        if let array = arrayObjectMaxTemp as? NSArray{
            maximumTemp = (array[indexPath.row]) as! String
        }
        //sunrise
        
        let arrayObjectSunrise = UserDefaults.standard.object(forKey: "Sunrise")
        if let array = arrayObjectSunrise as? NSArray{
            sunrise = (array[indexPath.row]) as! String
          
        }
        
        //sunset
        
        let arrayObjectSunset = UserDefaults.standard.object(forKey: "Sunset")
        if let array = arrayObjectSunset as? NSArray{
            sunset = (array[indexPath.row]) as! String
         
        }
        
        
        //windspeed
        let arrayObjectWindSpeed = UserDefaults.standard.object(forKey: "WindSpeed")
        if let array = arrayObjectWindSpeed as? NSArray{
            
            windSpeed = (array[indexPath.row]) as! String
   
        }
        
        let arrayObjectWindDegree = UserDefaults.standard.object(forKey: "WindDegree")
        if let array = arrayObjectWindDegree as? NSArray{
            
            windDegree = (array[indexPath.row]) as! String
            
        }
        
        //cloud
        
        let arrayObjectCloud = UserDefaults.standard.object(forKey: "Cloud")
        if let array = arrayObjectCloud as? NSArray{
            
            cloud = (array[indexPath.row]) as! String
            print(cloud)
        }
        
        vc?.pressure = pressure
        vc?.humidity = humidity
        vc?.visibility = visibility
        vc?.tempMin = minimumTemp
        vc?.tempMax = maximumTemp
        vc?.sunrise = sunrise
        vc?.sunset = sunset
        vc?.windDegree = windDegree
        vc?.windSpeed = windSpeed
        vc?.cloud = cloud
        vc?.weatherDescription = weatherDescription
        
        self.present(vc!, animated: true, completion: nil)
        
        
    }
    
    
    
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


