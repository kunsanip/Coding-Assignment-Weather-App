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
    var retrievingData: RetrievingData = RetrievingData()
    var networkLoading: NetworkLoading = NetworkLoading()
    var cityCodes = [4163971, 2147714, 2174003]//Melbourne //Sydney //Brisbane
    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // loading for some feedback to user while waiting for network response
        networkLoading.loading(string: "Loading..")
        
        DispatchQueue.global(qos: .background).async {
        
            
            self.retrievingData.retrieveData(citycode: self.cityCodes)
         
            SVProgressHUD.dismiss()

            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
   
    
 
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var count = 0
        let dictObjectTemperature = UserDefaults.standard.object(forKey: "Temperature")
        if let dict = dictObjectTemperature as? NSDictionary{
            count = dict.allValues.count
        }
       return count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
   
        let userDefaults = UserDefaults.standard
        let decoded = userDefaults.object(forKey: "weatherInfo") as! Data
        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [WeatherInfo]
        cell.city.text = decodedTeams[indexPath.row].cityName
        cell.avgTemp.text = decodedTeams[indexPath.row].cityTemp
        
        
        return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130 
    
    }
    
    
    //Expanding information when user tap on a cell to open a new "detail screen",
    //To show more information
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController
     
        
        let userDefaults = UserDefaults.standard
        let decoded = userDefaults.object(forKey: "weatherInfo") as! Data
        let decodedWeatherInfo = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [WeatherInfo]
        
        //Passing all the values to the detailed view controller
        vc?.cityName = decodedWeatherInfo[indexPath.row].cityName
        vc?.pressure = decodedWeatherInfo[indexPath.row].cityPressure
        vc?.humidity = decodedWeatherInfo[indexPath.row].cityHumidity
        vc?.visibility = decodedWeatherInfo[indexPath.row].cityVisibility
        vc?.temperature = decodedWeatherInfo[indexPath.row].cityTemp
        vc?.tempMin = decodedWeatherInfo[indexPath.row].cityMinTemp
        vc?.tempMax = decodedWeatherInfo[indexPath.row].cityMaxTemp
        vc?.sunrise = decodedWeatherInfo[indexPath.row].citySunrise
        vc?.sunset = decodedWeatherInfo[indexPath.row].citySunset
        vc?.windDegree = decodedWeatherInfo[indexPath.row].cityWindDegree
        vc?.windSpeed = decodedWeatherInfo[indexPath.row].cityWindSpeed
        vc?.cloud = decodedWeatherInfo[indexPath.row].cityCloud
        vc?.weatherDescription = decodedWeatherInfo[indexPath.row].cityWeatherDescription
        
        //displaying detailed view controller
        self.present(vc!, animated: true, completion: nil)
        
        
    }
    
    
  
    
}


