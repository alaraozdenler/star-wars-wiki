//
//  CharacterDetailView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 05.05.24.
//

import SwiftUI
import SWAPI

struct CharacterDetailView: View {
    var character: PeopleQuery.Data.AllPeople.Person
    var body: some View {
        ScrollView {
            NavigationStack {
                VStack (alignment: .leading) {
                    VStack (alignment: .leading) {
                        Text("Personal Information").font(.title3).fontWeight(.bold)
                        HStack {
                            Text("Birth Year: ").fontWeight(.bold)
                            Text(character.birthYear!)
                        }
                        HStack {
                            Text("Gender: ").fontWeight(.bold)
                            Text(character.gender!)
                        }
                        HStack {
                            Text("Homeworld: ").fontWeight(.bold)
                            Text((character.homeworld?.name)!)
                        }
                        HStack {
                            Text("Species: ").fontWeight(.bold)
                            if character.species == nil {
                                Text("-")
                            } else {
                                Text(((character.species?.name!)!))
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
                        Text("Physical Appearance").font(.title3).fontWeight(.bold)
                        HStack {
                            Text("Height: ").fontWeight(.bold)
                            Text(String(character.height!))
                        }
                        HStack {
                            Text("Eye Color: ").fontWeight(.bold)
                            Text(character.eyeColor!)
                        }
                        HStack {
                            Text("Skin Color: ").fontWeight(.bold)
                            Text(character.skinColor!)
                        }
                        HStack {
                            Text("Hair Color: ").fontWeight(.bold)
                            Text(character.hairColor!)
                        }
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.8, alignment: .leading)
                    .background(Color(.white))
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                    .padding(5)
                    
                    
                    VStack (alignment: .leading) {
                        Text("Vehicles").font(.title3).fontWeight(.bold)
                        if (character.vehicleConnection?.vehicles?.count == 0) {
                            Text("This character doesn't have a vehicle!")
                        } else {
                            ForEach((character.vehicleConnection?.vehicles)!, id: \.self) { vehicle in
                                Text((vehicle?.name)!)
                            }
                        }
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.8, alignment: .leading)
                    .background(Color(.white))
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                    .padding(5)
                }
                
                VStack (alignment: .leading) {
                    Text("Starships").font(.title3).fontWeight(.bold)
                    if (character.starshipConnection?.starships?.count == 0) {
                        Text("This character doesn't have a starship!")
                    } else {
                        ForEach((character.starshipConnection?.starships)!, id: \.self) { starship in
                            Text((starship?.name)!)
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
                    ForEach((character.filmConnection?.films)!, id: \.self) { film in
                        Text((film?.title)!)
                    }
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width*0.8, alignment: .leading)
                .background(Color(.white))
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.2), radius: 5)
                .padding(5)
                
                .navigationTitle(character.name!)
            }
        }
    }
}



