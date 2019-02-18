//
//  DetailedViewController.swift
//  Coding Assignment Weather App
//
//  Created by Sanip Shrestha on 2/16/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    
    var timer = Timer()
    var i = 1
    var citytext = "",
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
    cloudDegree = "",
    weatherDescription = ""
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var weatherCondition: UILabel!
    
    @IBOutlet weak var averageTemp: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        city.text = citytext
        averageTemp.text = temperature
        pressureLabel.text = pressure
        humidityLabel.text = humidity
        //screen animation
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(DetailedViewController.processTimer), userInfo: nil, repeats: true)
     
        
    }
    
    @objc func processTimer(){
        
        
        //frame_001_delay-0.07s
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
        
        if i == 47{
            i = 1
        }
        
        
    }
   
    
}
