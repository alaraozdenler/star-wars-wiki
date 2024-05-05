//
//  StarShipDetailView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 05.05.24.
//

import SwiftUI
import SWAPI

struct StarShipDetailView: View {
    var starship: StarShipsQuery.Data.AllStarships.Starship
    var body: some View {
        ScrollView {
            NavigationStack {
                VStack (alignment: .leading) {
                    VStack (alignment: .leading) {
                        Text("Starship Information").font(.title3).fontWeight(.bold)
                        HStack {
                            Text("Model: ").fontWeight(.bold)
                            Text(starship.model!)
                        }
                        HStack {
                            Text("Max Passengers: ").fontWeight(.bold)
                            Text(starship.passengers!)
                        }
                        HStack {
                            Text("Class: ").fontWeight(.bold)
                            Text(String(starship.starshipClass!))
                        }
                        HStack {
                            Text("Hyperdrive Rating: ").fontWeight(.bold)
                            if starship.hyperdriveRating == nil {
                                Text("-")
                            } else {
                                Text(String(starship.hyperdriveRating!))
                            }
                        }
                        HStack {
                            Text("Max Atmosphering Speed: ").fontWeight(.bold)
                            if starship.maxAtmospheringSpeed == nil {
                                Text("-")
                            } else {
                                Text(String(starship.maxAtmospheringSpeed!))
                            }
                        }
                        HStack {
                            Text("Crew: ").fontWeight(.bold)
                            if starship.crew == nil {
                                Text("-")
                            } else {
                                Text(starship.crew! + " personnel")
                            }
                        }
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.8, alignment: .leading)
                    .background(Color(.white))
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                    .padding(5)
                    
                    VStack (alignment: .leading) {
                        Text("Pilots").font(.title3).fontWeight(.bold)
                        if (starship.pilotConnection?.pilots?.count == 0) {
                            Text("This starship doesn't have a pilot!")
                        } else {
                            ForEach((starship.pilotConnection?.pilots)!, id: \.self) { pilot in
                                Text((pilot?.name)!)
                            }
                        }
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.8, alignment: .leading)
                    .background(Color(.white))
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                    .padding(5)
                    
                    VStack (alignment: .leading) {
                        Text("Films").font(.title3).fontWeight(.bold)
                        ForEach((starship.filmConnection?.films)!, id: \.self) { film in
                            Text((film?.title)!)
                        }
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.8, alignment: .leading)
                    .background(Color(.white))
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                    .padding(5)
                }
                .navigationTitle(starship.name!)
            }
        }
    }
}

