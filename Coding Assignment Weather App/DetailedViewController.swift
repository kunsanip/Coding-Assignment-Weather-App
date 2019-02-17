//
//  DetailedViewController.swift
//  Coding Assignment Weather App
//
//  Created by Sanip Shrestha on 2/16/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    var citytext = ""
    @IBOutlet weak var city: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        city.text = citytext
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
