// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class StarShipsQuery: GraphQLQuery {
  public static let operationName: String = "StarShips"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query StarShips { allStarships { __typename starships { __typename name model passengers pilotConnection { __typename pilots { __typename name } } filmConnection { __typename films { __typename title } } starshipClass hyperdriveRating maxAtmospheringSpeed crew } } }"#
    ))

  public init() {}

  public struct Data: SWAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.Root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("allStarships", AllStarships?.self),
    ] }

    public var allStarships: AllStarships? { __data["allStarships"] }

    /// AllStarships
    ///
    /// Parent Type: `StarshipsConnection`
    public struct AllStarships: SWAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.StarshipsConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("starships", [Starship?]?.self),
      ] }

      /// A list of all of the objects returned in the connection. This is a convenience
      /// field provided for quickly exploring the API; rather than querying for
      /// "{ edges { node } }" when no edge data is needed, this field can be be used
      /// instead. Note that when clients like Relay need to fetch the "cursor" field on
      /// the edge to enable efficient pagination, this shortcut cannot be used, and the
      /// full "{ edges { node } }" version should be used instead.
      public var starships: [Starship?]? { __data["starships"] }

      /// AllStarships.Starship
      ///
      /// Parent Type: `Starship`
      public struct Starship: SWAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.Starship }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
          .field("model", String?.self),
          .field("passengers", String?.self),
          .field("pilotConnection", PilotConnection?.self),
          .field("filmConnection", FilmConnection?.self),
          .field("starshipClass", String?.self),
          .field("hyperdriveRating", Double?.self),
          .field("maxAtmospheringSpeed", Int?.self),
          .field("crew", String?.self),
        ] }

        /// The name of this starship. The common name, such as "Death Star".
        public var name: String? { __data["name"] }
        /// The model or official name of this starship. Such as "T-65 X-wing" or "DS-1
        /// Orbital Battle Station".
        public var model: String? { __data["model"] }
        /// The number of non-essential people this starship can transport.
        public var passengers: String? { __data["passengers"] }
        public var pilotConnection: PilotConnection? { __data["pilotConnection"] }
        public var filmConnection: FilmConnection? { __data["filmConnection"] }
        /// The class of this starship, such as "Starfighter" or "Deep Space Mobile
        /// Battlestation"
        public var starshipClass: String? { __data["starshipClass"] }
        /// The class of this starships hyperdrive.
        public var hyperdriveRating: Double? { __data["hyperdriveRating"] }
        /// The maximum speed of this starship in atmosphere. null if this starship is
        /// incapable of atmosphering flight.
        public var maxAtmospheringSpeed: Int? { __data["maxAtmospheringSpeed"] }
        /// The number of personnel needed to run or pilot this starship.
        public var crew: String? { __data["crew"] }

        /// AllStarships.Starship.PilotConnection
        ///
        /// Parent Type: `StarshipPilotsConnection`
        public struct PilotConnection: SWAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.StarshipPilotsConnection }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("pilots", [Pilot?]?.self),
          ] }

          /// A list of all of the objects returned in the connection. This is a convenience
          /// field provided for quickly exploring the API; rather than querying for
          /// "{ edges { node } }" when no edge data is needed, this field can be be used
          /// instead. Note that when clients like Relay need to fetch the "cursor" field on
          /// the edge to enable efficient pagination, this shortcut cannot be used, and the
          /// full "{ edges { node } }" version should be used instead.
          public var pilots: [Pilot?]? { __data["pilots"] }

          /// AllStarships.Starship.PilotConnection.Pilot
          ///
          /// Parent Type: `Person`
          public struct Pilot: SWAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.Person }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String?.self),
            ] }

            /// The name of this person.
            public var name: String? { __data["name"] }
          }
        }

        /// AllStarships.Starship.FilmConnection
        ///
        /// Parent Type: `StarshipFilmsConnection`
        public struct FilmConnection: SWAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.StarshipFilmsConnection }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("films", [Film?]?.self),
          ] }

          /// A list of all of the objects returned in the connection. This is a convenience
          /// field provided for quickly exploring the API; rather than querying for
          /// "{ edges { node } }" when no edge data is needed, this field can be be used
          /// instead. Note that when clients like Relay need to fetch the "cursor" field on
          /// the edge to enable efficient pagination, this shortcut cannot be used, and the
          /// full "{ edges { node } }" version should be used instead.
          public var films: [Film?]? { __data["films"] }

          /// AllStarships.Starship.FilmConnection.Film
          ///
          /// Parent Type: `Film`
          public struct Film: SWAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.Film }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("title", String?.self),
            ] }

            /// The title of this film.
            public var title: String? { __data["title"] }
          }
        }
      }
    }
  }
}
