//
//  WeatherViewController.swift
//  Climate
//
//  Created by Stephen Selvaraj on 6/17/18.
//  Copyright © 2018 Stephen Selvaraj. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController , CLLocationManagerDelegate, ChangeCityDelegate {

    let weatherURL = "http://api.openweathermap.org/data/2.5/weather"
    
    let APP_ID = "ba26559864aba797f0eb191d148c17c2"
    
        

    
    @IBOutlet weak var City: UILabel!
    @IBOutlet weak var Temperature: UILabel!
    
    @IBOutlet weak var WeatherIcon: UIImageView!
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        
        if (location.horizontalAccuracy > 0 ) {
            locationManager.stopUpdatingLocation()
            //print( "Longiture = \(location.coordinate.longitude) and Latitude = \(location.coordinate.latitude)")
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            let params : [String : String] = ["lat" : String(latitude), "lon" : String(longitude), "appid" : APP_ID]
            
            // TODO continue lesson 150 to finish this app
            GetWeatherData(url: weatherURL, parameters : params)
        }
    }
    
    //Networking
    
    func GetWeatherData(url :String, parameters : [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJSON : JSON = JSON(response.value!)
                
                print (weatherJSON)
                
                self.updateWeatherData( json : weatherJSON)
                
            } else {
                print("Error \(response.result.error)")
                self.City.text = "Connection issues"
            }
        
        }
    }
    
    func updateWeatherData (json : JSON) {
        if let tempresult = json ["main"]["temp"].double {
            Temperature.text = String(tempresult-273.15)
            City.text = json["name"].stringValue
            
        }

        
        
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        City.text = "Error"
    }
    
    //TODO : Call the URL
    
    func userEnteredCity(city: String) {
        print (city)
        
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        GetWeatherData(url: weatherURL, parameters: params)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ChangeCityName" {
            
            let destinationVC = segue.destination as! SecondViewController
            
            destinationVC.delegate = self
            
        }
        
    }

}

