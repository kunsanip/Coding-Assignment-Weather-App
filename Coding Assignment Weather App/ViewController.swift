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
        
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController
        vc?.citytext = cities[indexPath.row]
        
        let arrayObject = UserDefaults.standard.object(forKey: "Temperature")
        if let array = arrayObject as? NSArray{
            let avgtemp = (array[indexPath.row]) as! String
            vc?.temperature = avgtemp as! String + "°"
            
        }
        /*if let array = arrayObject as? NSArray{
            let pressure = (array[indexPath.row]) as! String
            vc?.pressure = pressure as! String + "°"
            
        }*/
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
                            /*if let main = (jsonResult["main"] as? NSDictionary){
                                
                                let pressure = String(describing: main["pressure"] as! NSNumber)
                                
                                self.cityPressure.append(pressure)

                                UserDefaults.standard.set(self.cityPressure, forKey: "Pressure")
                                
                                
                            }*/
                            
                            
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

