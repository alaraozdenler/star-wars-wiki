// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SWAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SWAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SWAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SWAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Root": return SWAPI.Objects.Root
    case "PeopleConnection": return SWAPI.Objects.PeopleConnection
    case "Person": return SWAPI.Objects.Person
    case "Film": return SWAPI.Objects.Film
    case "Species": return SWAPI.Objects.Species
    case "Planet": return SWAPI.Objects.Planet
    case "Starship": return SWAPI.Objects.Starship
    case "Vehicle": return SWAPI.Objects.Vehicle
    case "PersonFilmsConnection": return SWAPI.Objects.PersonFilmsConnection
    case "PersonStarshipsConnection": return SWAPI.Objects.PersonStarshipsConnection
    case "PersonVehiclesConnection": return SWAPI.Objects.PersonVehiclesConnection
    case "PageInfo": return SWAPI.Objects.PageInfo
    case "PlanetsConnection": return SWAPI.Objects.PlanetsConnection
    case "PlanetFilmsConnection": return SWAPI.Objects.PlanetFilmsConnection
    case "PlanetResidentsConnection": return SWAPI.Objects.PlanetResidentsConnection
    case "StarshipsConnection": return SWAPI.Objects.StarshipsConnection
    case "StarshipPilotsConnection": return SWAPI.Objects.StarshipPilotsConnection
    case "StarshipFilmsConnection": return SWAPI.Objects.StarshipFilmsConnection
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
