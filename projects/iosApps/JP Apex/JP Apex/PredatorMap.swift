//
//  PredatorMap.swift
//  JP Apex
//
//  Created by Yash on 19/08/24.
//

import SwiftUI
import MapKit
struct PredatorMap: View {
    let predators = Predators()
    @State var satelite = false
    @State var position: MapCameraPosition
    var body: some View {
        Map(position: $position){
            ForEach(predators.allApexPredators){ predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .black,radius: 3)
                        .scaleEffect(x:-1)
                }
            }
        }
        .mapStyle(
            satelite ?
                .imagery(elevation: .realistic) :
                    .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button{
                satelite.toggle()
            }label: {
                Image(systemName: satelite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial).clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }.toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 1000,
                                            heading: 250, pitch: 80))).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
