//
//  DataLoader.swift
//  Final_PremSaiKrishna_Kandagattla
//
//  Created by user206624 on 8/16/22.
//

import Foundation

public class DataLoader{
    
    @Published var covidData=[CovidData]()
    
    init() {
        load()
    }
    
    func load(){
        if let fileLocation=Bundle.main.url(forResource:"covid_data",withExtension:"json"){
            // do catch in case of an error
            do{
                let data=try Data(contentsOf:fileLocation)
                let jsonDecoder=JSONDecoder()
                let dataFromJson=try jsonDecoder.decode([CovidData].self,from:data)
                self.covidData = dataFromJson
            }catch{
                print(error)
                
            }
        }
    }
}
