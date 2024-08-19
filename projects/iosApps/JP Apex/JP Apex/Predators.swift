//
//  Predators.swift
//  JP Apex
//
//  Created by Yash on 16/08/24.
//

import Foundation


class Predators{
    var apexPredators: [ApexPredator] = []
    var allApexPredators : [ApexPredator] = []
    init() {
        decodeApexPredatorData()
    }
    func decodeApexPredatorData(){
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do{
               let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            }catch{
                print("error decoding JSON data \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator]{
        if searchTerm.isEmpty{
            return apexPredators
        }
        else {
            return apexPredators.filter{ predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    func sort(by alphabatical: Bool){
        apexPredators.sort { predator1, predator2 in
            if alphabatical {
                  predator1.name < predator2.name
            }else {
                  predator1.id < predator2.id
            }
            
        }
        
    }
    func filter(by type: PredatorType){
        if(type == .all){
             apexPredators = allApexPredators
        }else{
            apexPredators = allApexPredators.filter{ predator in
               return predator.type == type
            }
        }
       
    }
}
