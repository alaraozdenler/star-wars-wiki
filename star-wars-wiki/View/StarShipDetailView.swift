//
//  StarShipDetailView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 05.05.24.
//

import SwiftUI
import SWAPI


struct StarShipDetailView: View {
    var starShip: StarShipsQuery.Data.AllStarships.Starship
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                VStack (alignment: .leading) {
                    Text("Star Ship Data").font(.title3).fontWeight(.bold)
                    
                    HStack {
                        Text("Model: ").fontWeight(.bold)
                        Text(starShip.model!)
                        
                    }
                    HStack {
                        Text("Max Passengers: ").fontWeight(.bold)
                        Text(starShip.passengers!)
                        
                    }
                    HStack {
                        Text("Class: ").fontWeight(.bold)
                        Text(String(starShip.starshipClass!))
                        
                    }
                    HStack {
                        Text("Hyperdrive Rating: ").fontWeight(.bold)
                        Text(String(starShip.hyperdriveRating!))
                        
                    }
                    HStack {
                        Text("Max Atmosphering Speed: ").fontWeight(.bold)
                        Text(String(starShip.maxAtmospheringSpeed!))
                        
                    }
                    HStack {
                        Text("Crew: ").fontWeight(.bold)
                        Text(starShip.crew! + " personnel")
                        
                    }
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width*0.8, alignment: .leading)
                .background(Color(.white))
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.2), radius: 5)
                
                VStack (alignment: .leading) {
                    Text("Films").font(.title3).fontWeight(.bold)
                    ForEach((starShip.filmConnection?.films)!, id: \.self) { film in
                        Text((film?.title)!)
                    }
                    
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width*0.8, alignment: .leading)
                .background(Color(.white))
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.2), radius: 5)
                
                VStack (alignment: .leading) {
                    Text("Pilots").font(.title3).fontWeight(.bold)
                    if (starShip.pilotConnection?.pilots?.count == 0) {
                        Text("This star ship doesn't have a pilot!")
                    } else {
                        ForEach((starShip.pilotConnection?.pilots)!, id: \.self) { pilot in
                            Text((pilot?.name)!)
                        }
                    }
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width*0.8, alignment: .leading)
                .background(Color(.white))
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.2), radius: 5)
            }
            .navigationTitle(starShip.name!)
        }
    }
}

