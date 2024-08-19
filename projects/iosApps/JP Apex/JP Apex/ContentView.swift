//
//  ContentView.swift
//  JP Apex
//
//  Created by Yash on 16/08/24.
//

import SwiftUI
import MapKit
struct ContentView: View {
    let predators = Predators()
    @State var searchText = ""
    @State var alphabatical = false
    @State var currentSelection = PredatorType.all
    
    var filteredDinos :[ApexPredator]{
        predators.filter(by: currentSelection)
        predators.sort(by: alphabatical)
        return predators.search(for: searchText)
    }
    
    
    var body: some View {
        NavigationStack{
            List(filteredDinos){ predator in
                NavigationLink{
                    PredatorDetail(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)), predator: predator)
                }label: {
                HStack{
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .shadow(color: .white, radius: 1)
                    VStack(alignment: .leading){
                        Text(predator.name)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text(predator.type.rawValue.capitalized)
                            .fontWeight(.semibold)
                            .font(.subheadline)
                            .padding(.horizontal, 13)
                            .padding(.vertical, 5)
                            .background(
                                predator.type.background
                            ).clipShape(.capsule)
                    }
                    
                }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        withAnimation{
                            alphabatical.toggle()
                        }
                    }label: {
                        Image(systemName: alphabatical ? "film": "textformat")
                            .symbolEffect(.bounce, value: alphabatical)
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Picker("filter", selection: $currentSelection.animation() ){
                            ForEach(PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type
                                    .icon)
                            }
                        }
                    }label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
