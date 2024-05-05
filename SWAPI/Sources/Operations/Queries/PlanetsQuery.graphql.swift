// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PlanetsQuery: GraphQLQuery {
  public static let operationName: String = "Planets"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Planets { allPlanets { __typename planets { __typename name population diameter filmConnection { __typename films { __typename title } } gravity orbitalPeriod rotationPeriod surfaceWater terrains residentConnection { __typename residents { __typename name } } } } }"#
    ))

  public init() {}

  public struct Data: SWAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.Root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("allPlanets", AllPlanets?.self),
    ] }

    public var allPlanets: AllPlanets? { __data["allPlanets"] }

    /// AllPlanets
    ///
    /// Parent Type: `PlanetsConnection`
    public struct AllPlanets: SWAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.PlanetsConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("planets", [Planet?]?.self),
      ] }

      /// A list of all of the objects returned in the connection. This is a convenience
      /// field provided for quickly exploring the API; rather than querying for
      /// "{ edges { node } }" when no edge data is needed, this field can be be used
      /// instead. Note that when clients like Relay need to fetch the "cursor" field on
      /// the edge to enable efficient pagination, this shortcut cannot be used, and the
      /// full "{ edges { node } }" version should be used instead.
      public var planets: [Planet?]? { __data["planets"] }

      /// AllPlanets.Planet
      ///
      /// Parent Type: `Planet`
      public struct Planet: SWAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.Planet }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
          .field("population", Double?.self),
          .field("diameter", Int?.self),
          .field("filmConnection", FilmConnection?.self),
          .field("gravity", String?.self),
          .field("orbitalPeriod", Int?.self),
          .field("rotationPeriod", Int?.self),
          .field("surfaceWater", Double?.self),
          .field("terrains", [String?]?.self),
          .field("residentConnection", ResidentConnection?.self),
        ] }

        /// The name of this planet.
        public var name: String? { __data["name"] }
        /// The average population of sentient beings inhabiting this planet.
        public var population: Double? { __data["population"] }
        /// The diameter of this planet in kilometers.
        public var diameter: Int? { __data["diameter"] }
        public var filmConnection: FilmConnection? { __data["filmConnection"] }
        /// A number denoting the gravity of this planet, where "1" is normal or 1 standard
        /// G. "2" is twice or 2 standard Gs. "0.5" is half or 0.5 standard Gs.
        public var gravity: String? { __data["gravity"] }
        /// The number of standard days it takes for this planet to complete a single orbit
        /// of its local star.
        public var orbitalPeriod: Int? { __data["orbitalPeriod"] }
        /// The number of standard hours it takes for this planet to complete a single
        /// rotation on its axis.
        public var rotationPeriod: Int? { __data["rotationPeriod"] }
        /// The percentage of the planet surface that is naturally occurring water or bodies
        /// of water.
        public var surfaceWater: Double? { __data["surfaceWater"] }
        /// The terrains of this planet.
        public var terrains: [String?]? { __data["terrains"] }
        public var residentConnection: ResidentConnection? { __data["residentConnection"] }

        /// AllPlanets.Planet.FilmConnection
        ///
        /// Parent Type: `PlanetFilmsConnection`
        public struct FilmConnection: SWAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.PlanetFilmsConnection }
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

          /// AllPlanets.Planet.FilmConnection.Film
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

        /// AllPlanets.Planet.ResidentConnection
        ///
        /// Parent Type: `PlanetResidentsConnection`
        public struct ResidentConnection: SWAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.PlanetResidentsConnection }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("residents", [Resident?]?.self),
          ] }

          /// A list of all of the objects returned in the connection. This is a convenience
          /// field provided for quickly exploring the API; rather than querying for
          /// "{ edges { node } }" when no edge data is needed, this field can be be used
          /// instead. Note that when clients like Relay need to fetch the "cursor" field on
          /// the edge to enable efficient pagination, this shortcut cannot be used, and the
          /// full "{ edges { node } }" version should be used instead.
          public var residents: [Resident?]? { __data["residents"] }

          /// AllPlanets.Planet.ResidentConnection.Resident
          ///
          /// Parent Type: `Person`
          public struct Resident: SWAPI.SelectionSet {
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
      }
    }
  }
}
