//
//  ApexPredator.swift
//  JP Apex
//
//  Created by Yash on 16/08/24.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable{
    let id : Int
    let name: String
    let type : PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    var image: String{
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    struct MovieScene: Decodable, Identifiable{
        let id: Int
        let movie: String
        let sceneDescription: String
        
    }
  
}
enum PredatorType: String, Decodable, CaseIterable, Identifiable{
    case all
    case land
    case air
    case sea
    
    var id: PredatorType{
        self
    }
    var background: Color{
        switch self{
        case .land:
                .brown
        case .sea:
                .blue
        case .air:
                .teal
        case .all:
                .black
        }
    }
    var icon: String{
        switch self{
        case .land:
                "leaf.fill"
        case .sea:
                "drop.fill"
        case .air:
                "wind"
        case .all:
                "square.stack.3d.up.fill"
        }
    }
}
