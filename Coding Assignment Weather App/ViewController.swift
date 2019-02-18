//
//  ViewController.swift
//  Coding Assignment Weather App
//
//  Created by Sanip Shrestha on 2/11/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    @IBOutlet weak var messageLabel: UILabel!
    let cities = ["Sydney","Brisbane","Melbourne"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*  let sydneycode = 4163971
         let melbournecode = 2147714
         let brisbanecode = 2174003*/
        
        retrievingData(citycode: 4163971)
        retrievingData(citycode: 2147714)
        retrievingData(citycode: 2174003)
        
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
        return 90 //putting up to 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var pressure = ""
        var humidity = ""
        var visibility = ""
        var minimumTemp = ""
        var maximumTemp = ""
        var sunrise = ""
        var sunset = ""
        var windSpeed = ""
        var windDegree = ""
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController
        vc?.citytext = cities[indexPath.row]
        
        let arrayObjectTemperature = UserDefaults.standard.object(forKey: "Temperature")
        if let array = arrayObjectTemperature as? NSArray{
            let avgtemp = (array[indexPath.row]) as! String
            vc?.temperature = avgtemp + "°"
            
            
        }
        
        //Pressure
        let arrayObjectPressure = UserDefaults.standard.object(forKey: "Pressure")
        if let array = arrayObjectPressure as? NSArray{
            pressure = (array[indexPath.row]) as! String
            
        }
        //humidity
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
            print(sunrise)
        }
        
        //sunset
        
        let arrayObjectSunset = UserDefaults.standard.object(forKey: "Sunset")
        if let array = arrayObjectSunset as? NSArray{
            sunset = (array[indexPath.row]) as! String
            print(sunset)
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
        
        
        vc?.pressure = pressure
        vc?.humidity = humidity
        vc?.visibility = visibility
        vc?.tempMin = minimumTemp
        vc?.tempMax = maximumTemp
        vc?.sunrise = sunrise
        vc?.sunset = sunset
        // vc?.windDegree = windDegree
        //vc?.windSpeed = windSpeed
        
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
                            
                            /*
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
                             
                             */
                            
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


