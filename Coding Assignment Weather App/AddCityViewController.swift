//
//  AddCityViewController.swift
//  Coding Assignment Weather App
//
//  Created by Sanip Shrestha on 2/23/19.
//  Copyright © 2019 Learning. All rights reserved.
//
import Foundation
import UIKit

class AddCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   
    
    var cityCodeList = [String:String]()
    var allCities = [String]()
    var filteredAllCities = [String]()
    var allCodes = [String]()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
       
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        getCityCodes()
        
        
        self.allCities = self.getAllcityNames()
        
        self.tableView.reloadData()
        
    }

   
   
    
    
   //search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty
            else{
                filteredAllCities = allCities
                tableView.reloadData()
                return
                
        }
        filteredAllCities = allCities.filter({ (city) -> Bool in
            guard let text = searchBar.text else {return false}
            print(city)
            print(text)
            return city.lowercased().contains(text.lowercased())
            
        })
       
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
 

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("count: \(allCities.count)")

        return filteredAllCities.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCityCell", for: indexPath) as! AddCities
        
    
       
        cell.cityName.text! = (filteredAllCities[indexPath.row]) as String
        
        return cell
        
    }
    
    //Work here for latter part 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        let citycode = (cityCodeList[filteredAllCities[indexPath.row]]!)
        print(citycode)
        vc?.newCityCode = (cityCodeList[filteredAllCities[indexPath.row]]!)
     print(filteredAllCities[indexPath.row])
        vc?.newCity = filteredAllCities[indexPath.row]
        
        self.present(vc!, animated: true, completion: nil)
        
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


