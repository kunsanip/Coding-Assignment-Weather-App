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
  
    
    
    var retrievingData: RetrievingData = RetrievingData()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    var cities = ["Sydney","Brisbane","Melbourne"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*  let sydneycode = 4163971
         let melbournecode = 2147714
         let brisbanecode = 2174003*/
        Loading(string: "Loading..")
        DispatchQueue.global(qos: .background).async {
        self.retrievingData.retrievingData(citycode: 4163971)
        self.retrievingData.retrievingData(citycode: 2147714)
        self.retrievingData.retrievingData(citycode: 2174003)
     
            if self.newCity != "" {
                print(self.cities)
                let cityName = String(self.newCity.filter { !" \n\t\r".contains($0) })
                self.cities.append(cityName)
                print(self.cities)
                self.retrievingData.retrievingData(citycode: Int(self.newCityCode)!)
            }
            
        SVProgressHUD.dismiss()
        }
        
        self.tableView.reloadData()

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
    
    
  
    
    
}


