//
//  AddCityViewController.swift
//  Coding Assignment Weather App
//
//  Created by Sanip Shrestha on 2/23/19.
//  Copyright © 2019 Learning. All rights reserved.
//
import Foundation
import UIKit

class AddCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 var array = ["sanip","shrestha","whatever"]
    var cityCodeList = [String:String]()
    var allCities = [String]()
    var allCodes = [String]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
       
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("reload")
        
        getCityCodes()
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.allCities = self.getAllcityNames()
        print("dispatch")
        
        self.tableView.reloadData()
        
    }

   
    @objc func textFieldDidChange(_ textField: UITextField) {
       tableView.reloadData()
        
    }
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
 

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       print(allCities.count)

        return allCities.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCityCell", for: indexPath) as! AddCities
        
    
       
        cell.cityName.text! = (allCities[indexPath.row]) as String
        
        return cell
        
    }


    func getAllcityNames() -> [String]
    {
        
        return Array(cityCodeList.keys)
    }
    
    func getAllcitycodes() -> [String]
    {
        
        return Array(cityCodeList.values)
    }
    //getting all the text file data from citycodeList and storing into a dictionary
    func getCityCodes(){
        
        let path = "/Users/Admin/Desktop/Coding Assignment Weather App/Coding Assignment Weather App/citycodeList.txt"
        
        do {
            // Read an entire text file into an NSString.
            let contents = try NSString(contentsOfFile: path,
                                        encoding: String.Encoding.ascii.rawValue)
            if let cityArray = contents.components(separatedBy: ",") as? [String]{
                // Print all lines.
                for city in cityArray{
                    let citycomponent = city.components(separatedBy: ":")
                    cityCodeList[citycomponent[0]] = citycomponent[1]
                    
                }
                
            }
        }
        catch{
            print("Did not read..")
        }
    }
    }


