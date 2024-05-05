//
//  PlanetDetailView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 05.05.24.
//

import SwiftUI
import SWAPI

struct PlanetDetailView: View {
    var planet: PlanetsQuery.Data.AllPlanets.Planet
    var body: some View {
        ScrollView {
            NavigationStack {
                VStack (alignment: .leading) {
                    VStack (alignment: .leading) {
                        Text("Planet Information").font(.title3).fontWeight(.bold)
                        HStack {
                            Text("Population: ").fontWeight(.bold)
                            if planet.population == nil {
                                Text("-")
                            } else {
                                Text(String(planet.population!))
                            }
                        }
                        HStack {
                            Text("Diameter: ").fontWeight(.bold)
                            if planet.diameter == nil {
                                Text("-")
                            } else {
                                Text(String(planet.diameter!))
                            }
                        }
                        HStack {
                            Text("Gravity: ").fontWeight(.bold)
                            Text(planet.gravity!)
                        }
                        HStack {
                            Text("Orbital Period: ").fontWeight(.bold)
                            if planet.orbitalPeriod == nil {
                                Text("-")
                            } else {
                                Text(String(planet.orbitalPeriod!))
                            }
                        }
                        HStack {
                            Text("Rotation Period: ").fontWeight(.bold)
                            if planet.rotationPeriod == nil {
                                Text("-")
                            } else {
                                Text(String(planet.rotationPeriod!))
                            }
                        }
                        HStack {
                            Text("Surface Water: ").fontWeight(.bold)
                            if planet.surfaceWater == nil {
                                Text("-")
                            } else {
                                Text(String(planet.surfaceWater!))
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
                        Text("Residents").font(.title3).fontWeight(.bold)
                        if (planet.residentConnection?.residents?.count == 0) {
                            Text("This planet doesn't have any residents!")
                        } else {
                            ForEach((planet.residentConnection?.residents)!, id: \.self) { resident in
                                Text((resident?.name)!)
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
                        if (planet.filmConnection?.films?.count == 0) {
                            Text("This planet isn't referenced in any films!")
                        } else {
                            ForEach((planet.filmConnection?.films)!, id: \.self) { film in
                                Text((film?.title)!)
                            }
                        }
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.8, alignment: .leading)
                    .background(Color(.white))
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                    .padding(5)
                    
                    .navigationTitle(planet.name!)
                }
            }
        }
    }}

