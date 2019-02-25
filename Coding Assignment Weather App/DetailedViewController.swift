//
//  DetailedViewController.swift
//  Coding Assignment Weather App
//
//  Created by Sanip Shrestha on 2/16/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

   //Initialising Variable
    var timer = Timer()
    var i = 1 //required for func processTimer 
    var cityName = "",
    temperature = "",
    humidity = "",
    sunrise = "",
    sunset = "",
    pressure = "Pressure",
    tempMin = "",
    tempMax = "",
    visibility = "",
    windSpeed = "",
    windDegree = "",
    cloud = "",
    weatherDescription = ""
    
    var timestampconverter = TimeStampConverter()
   
  //IBOutlets
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDescripitionLabel: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var averageTemp: UILabel!
    
      let header = ["Pressure", "Humidity", "Visibility", "Sunrise", "Sunset","Wind Speed", "Wind Degree", "Cloud",""]
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        city.text = cityName
        if let today = timestampconverter.today(timeStamp: Int(sunrise)!) as? String{
            todayLabel.text = today
        }
        weatherCondition.text = weatherDescription
        averageTemp.text = temperature
        temperatureLabel.text = "\(tempMax)    \(tempMin)"
        weatherDescripitionLabel.text = "Today: \(weatherDescription) currently. The high will be \(tempMax)° and a low will be \(tempMin)°."
        
        //screen animation
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(DetailedViewController.processTimer), userInfo: nil, repeats: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    
    //Animation
    @objc func processTimer(){
       

        
        //frame_001_delay-0.07s
        if i == 1{
            image.alpha = 0
            UIView.animate(withDuration: 1, animations: {self.image.alpha = 1})
        }
        image.image = UIImage(named: "frame_00\(i)_delay-0.07s.gif")
        
        if i<10{
            
            image.image = UIImage(named: "frame_00\(i)_delay-0.07s.gif")
        }
            
        else if i<100{
            image.image = UIImage(named: "frame_0\(i)_delay-0.07s.gif")
            
            
            
        }
        else{
            image.image = UIImage(named: "frame_\(i)_delay-0.07s.gif")
            
            
        }
        i += 1
        
        if i == 198{
            i = 1
            UIView.animate(withDuration: 1, animations: {self.image.alpha = 1})
        }
        
        
        
    }
    
   
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return header.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        
    {
        //        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! DetailedVCTableViewCell
        
        var data = [pressure + "hPA", humidity + "%", visibility + "km", timestampconverter.timeStampConvert(timeStamp: Int(sunrise)!), timestampconverter.timeStampConvert(timeStamp: Int(sunset)!), windSpeed + "m/s", windDegree + "°", cloud + "%", ""]
        cell.header.text! = header[indexPath.row]
        print(indexPath.row)
        cell.information.text! = data[indexPath.row]// data[indexPath.row]
        
        return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 //putting up to 90
    }
    
    
    
}
