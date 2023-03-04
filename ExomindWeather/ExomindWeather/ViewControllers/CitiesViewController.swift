//
//  CitiesViewController.swift
//  ExomindWeather
//
//  Created by Samir on 4/3/23.
//

import UIKit
import Lottie
class CitiesViewController: UIViewController {
    @IBOutlet  weak var statusMessage:UILabel?
    @IBOutlet  weak var restartButton:UIButton!
    @IBOutlet  weak var progressBar:UIProgressView!
    @IBOutlet  weak var tableView:UITableView!
    private var citiesList: [City] = []
    private var citiesWeatherList: [CityObject] = []
    
    private var currentCityName = ""
    private var timer:Timer?
    private var lat: Double?
    private var lon: Double? {
        didSet {
            showCurrentWeather()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.estimatedRowHeight = 99
        setupCitiesList()
       
    }
    
    private func autoUpdateWeather(){
        
        if self.citiesWeatherList.count == 0 && citiesList.count > 0{
            self.lon = self.citiesList[self.citiesWeatherList.count].coord.lon
            self.lat = self.citiesList[self.citiesWeatherList.count].coord.lat
            self.currentCityName  = self.citiesList[self.citiesWeatherList.count].name
            weatherTimer()
            
        }else if citiesList.count > 0 && citiesList.count > self.citiesWeatherList.count {
            weatherTimer()
        }else{
            timer?.invalidate()
            timer = nil
            
        }
    }
    
    private func weatherTimer(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
            if self.citiesList.count > 0 && self.citiesList.count > self.citiesWeatherList.count {
            
            self.currentCityName  = self.citiesList[self.citiesWeatherList.count].name
            self.lon = self.citiesList[self.citiesWeatherList.count].coord.lon
            self.lat = self.citiesList[self.citiesWeatherList.count].coord.lat
            }else{
                self.timer?.invalidate()
                self.timer = nil
            }
        }
    }
    
    private func setupCitiesList() {
        DispatchQueue.main.async {
            self.citiesList = CitiesListManager.shared.fetchCitiesList()
            self.autoUpdateWeather()
        }
    }
    
    
    private func showCurrentWeather() {
        
        self.statusMessage?.text = "Nous téléchargeons les données..."
        
        NetworkManager.shared.fetchWeather(lat: self.lat, lon: self.lon) { [self] weather in
        
    
            let cityobj = CityObject()
            cityobj.current = CurrentObject()
            cityobj.current.temp = weather!.current.temp
            cityobj.current.humidity = weather!.current.humidity
            cityobj.current.pressure = weather!.current.pressure
            cityobj.current.windSpeed = weather!.current.windSpeed
            cityobj.coordinate = CoordinateObject()
            cityobj.coordinate.lon = lon ?? 0.0
            cityobj.coordinate.lat = lat ?? 0.0
            cityobj.name = self.currentCityName
            let weatherObj = WeatherObject()
            weatherObj.icon = weather!.current.weather.first?.icon ?? ""
            weatherObj.main = weather!.current.weather.first?.main ?? ""
            cityobj.current.weather.append(weatherObj)
            self.citiesWeatherList.append(cityobj)
            self.progressBar?.progress += 0.2
          
            DispatchQueue.main.async {
           
            self.statusMessage?.text = "Plus que quelques secondes avant d'avoir le résultat..."
            if self.progressBar.progress >= 0.8 {
                self.statusMessage?.text = "C'est presque fini..."
            }
                
            if self.progressBar.progress == 1.0 {
                self.statusMessage?.text = ""
                self.statusMessage?.isHidden = true
                self.progressBar.isHidden = true
                self.restartButton.isHidden = false
                self.progressBar?.progress = 0.0
            }
            self.tableView?.reloadData()
            }
            
           
        }
        
            
    }
    @IBAction func restart(){
        if self.timer != nil {
            self.timer?.invalidate()
        
        }
        self.statusMessage?.text = ""
        self.statusMessage?.isHidden = false
        self.progressBar.isHidden = false
        self.restartButton.isHidden = true
        
        self.citiesList = []
        self.citiesWeatherList = []
        self.tableView?.reloadData()
        setupCitiesList()
    }
    
}

extension CitiesViewController:UITableViewDelegate,UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.citiesWeatherList.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
               let city = citiesWeatherList[indexPath.row]
                cell.cityNameLabel.text = city.name
                cell.animationView.isHidden = false
           
            if city.current.temp == 0.0 {
                cell.tempLabel.text = "-°C"
            }else{
                cell.tempLabel.text = "\(city.current.temp) °C"
            }
            
            if city.current.weather.first?.icon == "" {
                cell.animationView.isHidden = true
            }else{
                cell.animationView.isHidden = false
                cell.animationView.animation = LottieAnimation.named(city.current.weather.first?.icon ?? "")
                cell.animationView.loopMode = .loop
                cell.animationView.play()
            }
            
            
            return cell
        }

        
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 99
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}


