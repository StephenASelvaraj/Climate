//
//  SecondViewController.swift
//  Climate
//
//  Created by Stephen Selvaraj on 6/17/18.
//  Copyright © 2018 Stephen Selvaraj. All rights reserved.
//

import UIKit

//write the protocol

protocol ChangeCityDelegate {
    func userEnteredCity (city : String)
}

class SecondViewController: UIViewController {

    var delegate : ChangeCityDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBOutlet weak var CityNameTextField: UITextField!
    
    @IBOutlet weak var userEnteredCity: UILabel!
    
    @IBAction func GetWeather(_ sender: Any) {
        
        let cityName = CityNameTextField.text!
        
        delegate?.userEnteredCity(city: cityName)
        
        BacktoMainWeatherScreen(sender)
        
    }
    
    @IBAction func BacktoMainWeatherScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
