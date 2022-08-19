//
//  ViewController.swift
//  Final_PremSaiKrishna_Kandagattla
//
//  Created by user206624 on 8/16/22.
//

import UIKit
import Charts
import CoreLocation

class HomeViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var totalWorldConfirmed: UILabel!
    @IBOutlet weak var totalWorldDeaths: UILabel!
    @IBOutlet weak var totalWorldRecovered: UILabel!
    @IBOutlet weak var deathOverConfirmed: UILabel!
    @IBOutlet weak var recoveredOverConfirmed: UILabel!
    
    @IBOutlet weak var currentLocation: UILabel!
    
    @IBOutlet weak var currentLocationConfirmedCases: UILabel!
    @IBOutlet weak var currentLocationDeaths: UILabel!
    @IBOutlet weak var currentLocationRecovered: UILabel!
    
    @IBOutlet weak var applogo: UIImageView!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var AvoidInfectionBtn: UIButton!
    @IBOutlet weak var SelfAssessmentBtn: UIButton!
    
    @IBOutlet weak var totalConfirmedStack: UIStackView!
    @IBOutlet weak var totalDeathStack: UIStackView!
    @IBOutlet weak var totalRecoveredStack: UIStackView!
    
    // Used for Calcuating ratios
    var worldConfirmed: Int = 0
    var worldDeaths: Int = 0
    var worldRecovered: Int = 0
    
    // Location Variables
    var locationManager: CLLocationManager!
    var latitude = 0.0
    var longitude = 0.0
    
    // Invoking data loader for fetching covid data from json
    var data = DataLoader().covidData
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Initalization if the Data not found
        self.currentLocation.text = "NA"
        self.currentLocationConfirmedCases.text = "NA"
        self.currentLocationDeaths.text = "NA"
        self.currentLocationRecovered.text = "NA"
        
        // hiding the navigation bar
        self.navigationController?.navigationBar.isHidden = true
        
        // location functionalities
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager?.requestWhenInUseAuthorization()
        checkLocationPermission()
        
        // Calling members
        DisplayWorldData()
        DisplayBarChartData()
        
        // CSS Changes
        modifyCSSImage(sender: applogo )
        modifyCSSUIView(sender: barChartView)
        modifyCSSButton(sender: AvoidInfectionBtn, buttonColor: UIColor.systemGreen, textColor: UIColor.black)
        modifyCSSButton(sender: SelfAssessmentBtn, buttonColor: UIColor.systemBlue)
        
        modifyCSSStackView(sender: totalConfirmedStack, color: UIColor.init(rgbColorCodeRed: 238, green: 232, blue: 213, alpha: 1))
        modifyCSSStackView(sender: totalRecoveredStack, color: UIColor.init(rgbColorCodeRed: 238, green: 232, blue: 213, alpha: 1))
        modifyCSSStackView(sender: totalDeathStack, color: UIColor.init(rgbColorCodeRed: 238, green: 232, blue: 213, alpha: 1))
        
    }
    
    // View appear check for location permissions
    override func viewDidAppear(_ animated: Bool) {
        checkLocationPermission()
    }
    
    // Action buttons for navigation
    @IBAction func AvoidInfectionBtn(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "AvoidInfectionViewController") as! AvoidInfectionViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func SelfAssessmentBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "SelfAssessmentViewController") as! SelfAssessmentViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Displaying World Data
    func DisplayWorldData(){
                
        // Get Total Data of World
        worldConfirmed = data[0].totalConfirmed!
        worldDeaths = data[0].totalDeaths!
        worldRecovered = data[0].totalRecovered!
        
        // Display Total Cases Data on UI
        
        totalWorldConfirmed.text = String(worldConfirmed)
        totalWorldDeaths.text = String(worldDeaths)
        totalWorldRecovered.text = String( worldRecovered)
        
        // Calculate Ration for Death/Confirmed and Recovered/Confirmed
        let deathRatio = Double(worldDeaths)/Double(worldConfirmed) * 100
        let recoveredRatio = Double(worldRecovered) / Double(worldConfirmed) * 100
        
        deathOverConfirmed.text = String(format: "%.2f %%", deathRatio)
        recoveredOverConfirmed.text = String(format: "%.2f %%", recoveredRatio)
    }
    
    // Fetch Current location of user and display data
    func DisplayCurrentLocationData(){
        
        // Getting Reverse Location based on the latitude longitude of current location
        reverseLocation(finish: {
          error, country in
                if(!error){
                    DispatchQueue.main.async {
                        self.currentLocation.text = country;
                        
                        // If current location found then iterating over the covid data to get the values
                        if(self.currentLocation.text != nil && self.currentLocation.text != "NA"){
                            let countries = self.data[0].areas
                            
                            let CurrentCountry = self.currentLocation.text!.lowercased().replacingOccurrences(of: " ", with: "")
                            print(CurrentCountry)
                            self.currentLocationConfirmedCases.text = "NA"
                            self.currentLocationRecovered.text = "NA"
                            self.currentLocationDeaths.text = "NA"
                            
                            for countryIndex in countries {
                                
                                if (CurrentCountry  == countryIndex.id){
                                    
                                    if let value = (countryIndex.totalConfirmed as? Int){
                                        self.currentLocationConfirmedCases.text = String(value)
                                    }
                                    
                                    if let value = (countryIndex.totalDeaths as? Int){
                                        self.currentLocationDeaths.text = String(value)
                                    }
                                    
                                    if let value = (countryIndex.totalRecovered as? Int){
                                        self.currentLocationRecovered.text = String(value )
                                    }
                                    break
                                }
                            }
                        } else {
                            print("unable to find the country!!!")
                            self.currentLocation.text = "NA"
                            self.currentLocationConfirmedCases.text = "NA"
                            self.currentLocationRecovered.text = "NA"
                            self.currentLocationDeaths.text = "NA"
                            
                            let alert = UIAlertController.init(title: "Message", message: "Unable to find the location for this coordinates", preferredStyle: .alert)
                            let alertAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                            alert.addAction(alertAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.currentLocation.text = "NA";
                    }
                }
        })
        
        
        
        
    }
    
    // finding the reverse location country from location coordinates
    func reverseLocation(finish: @escaping ((error:Bool, data:String?)) -> Void){
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { placemark, error in
                guard let placemark = placemark, error == nil else {
                    finish((true, "Unable to find the Country"))
                    return
                }
            print(placemark.last!.country as Any)
            
            let country = placemark.last!.country
            
            finish((false, country))
                
            }

    }

    // Displaying Barchar data
    func DisplayBarChartData(){
        barChartView.delegate = self
        barChartView.noDataText = "Unable to fetch data for the chart."
        
        if (data == nil){
            return
        }
        
        // Adding Data to the Barchart View
        var totalWorldValues = [data[0].totalConfirmed ?? 0,  data[0].totalDeaths ?? 0, data[0].totalRecovered ?? 0]
        var entries = [BarChartDataEntry]()
        for (index,data) in totalWorldValues.enumerated(){
            entries.append(BarChartDataEntry(x: Double(index), y: Double(data ?? 0)))
        }
        
        let set = BarChartDataSet(entries: entries)
        set.colors = [UIColor.init(rgbColorCodeRed: 20, green: 160, blue: 241, alpha: 1),
                      UIColor.init(rgbColorCodeRed: 27, green: 170, blue: 47, alpha: 1),
                      UIColor.init(rgbColorCodeRed: 119, green: 230, blue: 119, alpha: 1)]
        set.label = "World Wide Covid-19 Cases Data"
        
        let data = BarChartData(dataSet: set)
        barChartView.data = data
        
        // Modifications for Barchart View
        // Barchart view
        barChartView.backgroundColor = UIColor.init(rgbColorCodeRed: 255, green: 255, blue: 0, alpha: 0.2)
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 3.0)
        barChartView.extraBottomOffset = 20
        barChartView.extraTopOffset = 20
        
        // Bar data Changes
        barChartView.barData?.setValueFont(UIFont.systemFont(ofSize: 12))
        barChartView.barData?.barWidth = Double(0.08) * 3
        
        //legend
        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .horizontal
        legend.drawInside = true
        
        // X axis configurations
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Confirmed","Deaths","Recovered"])
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barChartView.xAxis.labelCount = 3
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.granularityEnabled = true
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12.0)
        barChartView.xAxis.gridLineWidth = 10
        barChartView.xAxis.labelPosition = .bottom
        
        //left y axis line hide
        barChartView.getAxis(.left).axisLineColor = UIColor.clear
        
        // dotted line show
        barChartView.leftAxis.gridColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        barChartView.leftAxis.gridLineWidth = CGFloat(1)
        barChartView.leftAxis.gridLineDashLengths = [4,4]
        barChartView.leftAxis.axisMinimum = 0
        
        // Right axis configurations
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawLabelsEnabled = false
             
        // Other configurations
        barChartView.highlightPerDragEnabled = false
        barChartView.pinchZoomEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.scaleYEnabled = false
        barChartView.drawMarkers = true
        
    }
 
    
    // Checking the location services and display alert
    func checkLocationPermission(){
        
        if CLLocationManager.locationServicesEnabled() {
            let authorizationStatus = CLLocationManager.authorizationStatus()
            
            switch authorizationStatus {
            case .restricted, .denied:
                let alert = UIAlertController.init(title: "Location Service Disabled", message: "To re-enable ,please go to Settings and turn on Location Service for this app", preferredStyle: .alert)
                let alertAction = UIAlertAction.init(title: "Back", style: .cancel, handler: {_ in
                    self.navigationController?.popViewController(animated: true)
                })
                let alertSettingsAction = UIAlertAction.init(title: "Settings", style: .default) { (settings) in
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                }
                alert.addAction(alertAction)
                alert.addAction(alertSettingsAction)
                self.present(alert, animated: true, completion: nil)
                break
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager.startUpdatingLocation()
                break
            case .notDetermined:
                break
            }
        } else {
            print("Location services are not enabled")
            let alert = UIAlertController.init(title: "Location Service Disabled",
                                               message: "To re-enable ,please go to Settings and turn on Location Service for this app",
                                               preferredStyle: .alert)
            let alertAction = UIAlertAction.init(title: "Back", style: .cancel, handler: {_ in
                self.navigationController?.popViewController(animated: true)
            })
            let alertSettingsAction = UIAlertAction.init(title: "Settings", style: .default) { (settings) in
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            }
            alert.addAction(alertAction)
            alert.addAction(alertSettingsAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

// Adding Location functionality to fetch the current user location details
extension HomeViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let _ = locations.first {
            manager.startUpdatingLocation()
            let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
            self.latitude = locationValue.latitude;
            self.longitude = locationValue.longitude;
            print("latitude = \(self.latitude) longitude = \(self.longitude)")
            
        }
        
        self.DisplayCurrentLocationData();
                
   }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            let alert = UIAlertController.init(title: "Location Service Disabled", message: "To re-enable ,please go to Settings and turn on Location Service for this app", preferredStyle: .alert)
            let alertAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: {_ in
                self.navigationController?.popViewController(animated: true)
            })
            let alertSettingsAction = UIAlertAction.init(title: "Settings", style: .default) { (settings) in
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            }
            alert.addAction(alertAction)
            alert.addAction(alertSettingsAction)
            self.present(alert, animated: true, completion: nil)
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                self.DisplayCurrentLocationData()
            }
            break
        case .notDetermined:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
