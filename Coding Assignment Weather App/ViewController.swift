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
    
    
    //Intialising Variables
    var cities = ["Sydney","Brisbane","Melbourne"]
    var temperature = [String]()
    var retrievingData: RetrievingData = RetrievingData()
    var networkLoading: NetworkLoading = NetworkLoading()
    
    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // loading for some feedback to user while waiting for network response
      

        
    }
    override func viewDidAppear(_ animated: Bool) {
      
        networkLoading.loading(string: "Loading..")
        
        DispatchQueue.global(qos: .background).async {
            
            self.retrievingData.retrieveData(citycode: 4163971) //Melbourne
            self.retrievingData.retrieveData(citycode: 2147714) //Sydney
            self.retrievingData.retrieveData(citycode: 2174003) //Brisbane
            
            
            SVProgressHUD.dismiss()
            
        }
        
        //refreshing tableview data
        self.tableView.reloadData()
     

    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return cities.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
   
        
       
       
        
        //Each cell should display two pieces of info
        let dictObject = UserDefaults.standard.object(forKey: "Temperature")

        //1. Name of the city on the left
        if let dict = dictObject as? NSDictionary{
             print(dict)
            if let city = Array(dict.allKeys)[indexPath.row] as? String{
                cell.city.text! = city

            }

        else{
            cell.city.text! = "city1"
        }
        }
        else{

            cell.city.text! = "city2"
        }

        //2. Temperature on the right

        if let dict = dictObject as? NSDictionary{

            if let temp = Array(dict.allValues)[indexPath.row] as? String{
                cell.avgTemp.text! = "\(temp)°"

            }

            else{
                cell.avgTemp.text! = "temp"
            }
        }
        else{

            cell.avgTemp.text! = "temp"
        }
        return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130 
    
    }
    
    
    //Expanding information when user tap on a cell to open a new "detail screen",
    //To show more information
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
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController
     
        
       
        let dictObjectTemperature = UserDefaults.standard.object(forKey: "Temperature")
        if let dict = dictObjectTemperature as? NSDictionary{
            let avgtemp = (dict.allValues[indexPath.row]) as! String
            vc?.temperature = avgtemp + "°"
            vc?.cityName = (dict.allKeys[indexPath.row]) as! String

            
        }
        //Weather Description
        let dictObjectWeather =  UserDefaults.standard.object(forKey: "WeatherDescription")

        if let dict = dictObjectWeather as? NSDictionary{
            weatherDescription = (dict.allValues[indexPath.row]) as! String
            
        }
        
        
        //Pressure
        let dictObjectPressure = UserDefaults.standard.object(forKey: "Pressure")
        if let dict = dictObjectPressure as? NSDictionary{
            pressure = (dict.allValues[indexPath.row]) as! String
            
        }
        //Humidity
        let dictObjectHumidity = UserDefaults.standard.object(forKey: "Humidity")
        if let dict = dictObjectHumidity as? NSDictionary{
            humidity = (dict.allValues[indexPath.row]) as! String
            
        }
        //visibility
        
        
        let dictObjectVisibility = UserDefaults.standard.object(forKey: "Visibility")
        if let dict = dictObjectVisibility as? NSDictionary{
            visibility = (dict.allValues[indexPath.row]) as! String
        }
        
        
        
        //minimum temperature
        let dictObjectMinTemp = UserDefaults.standard.object(forKey: "MinTemp")
        if let dict = dictObjectMinTemp as? NSDictionary{
            minimumTemp = (dict.allValues[indexPath.row]) as! String
        }
        //maximum temperature
        let dictObjectMaxTemp = UserDefaults.standard.object(forKey: "MaxTemp")
        if let dict = dictObjectMaxTemp as? NSDictionary{
            maximumTemp = (dict.allValues[indexPath.row]) as! String
        }
        //sunrise
        
        let dictObjectSunrise = UserDefaults.standard.object(forKey: "Sunrise")
        if let dict = dictObjectSunrise as? NSDictionary{
            sunrise = (dict.allValues[indexPath.row]) as! String
          
        }
        
        //sunset
        
        let dictObjectSunset = UserDefaults.standard.object(forKey: "Sunset")
        if let dict = dictObjectSunset as? NSDictionary{
            sunset = (dict.allValues[indexPath.row]) as! String
         
        }
        
        
        //windspeed
        let dictObjectWindSpeed = UserDefaults.standard.object(forKey: "WindSpeed")
        if let dict = dictObjectWindSpeed as? NSDictionary{
            
            windSpeed = (dict.allValues[indexPath.row]) as! String
   
        }
        
        let dictObjectWindDegree = UserDefaults.standard.object(forKey: "WindDegree")
        if let dict = dictObjectWindDegree as? NSDictionary{
            
            windDegree = (dict.allValues[indexPath.row]) as! String
            
        }
        
        //cloud
        
        let dictObjectCloud = UserDefaults.standard.object(forKey: "Cloud")
        if let dict = dictObjectCloud as? NSDictionary{
            
            cloud = (dict.allValues[indexPath.row]) as! String
            print(cloud)
        }
        
        
        //Passing all the values to the detailed view controller
        
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
        
        //displaying detailed view controller
        self.present(vc!, animated: true, completion: nil)
        
        
    }
    
    
  
    
}


