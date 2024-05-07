// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PeopleQuery: GraphQLQuery {
  public static let operationName: String = "People"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query People($after: String, $first: Int) { allPeople(after: $after, first: $first) { __typename people { __typename name filmConnection { __typename films { __typename title } } birthYear homeworld { __typename name } gender height hairColor eyeColor skinColor species { __typename name } starshipConnection { __typename starships { __typename name } } vehicleConnection { __typename vehicles { __typename name } } id } pageInfo { __typename hasNextPage endCursor } } }"#
    ))

  public var after: GraphQLNullable<String>
  public var first: GraphQLNullable<Int>

  public init(
    after: GraphQLNullable<String>,
    first: GraphQLNullable<Int>
  ) {
    self.after = after
    self.first = first
  }

  public var __variables: Variables? { [
    "after": after,
    "first": first
  ] }

  public struct Data: SWAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.Root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("allPeople", AllPeople?.self, arguments: [
        "after": .variable("after"),
        "first": .variable("first")
      ]),
    ] }

    public var allPeople: AllPeople? { __data["allPeople"] }

    /// AllPeople
    ///
    /// Parent Type: `PeopleConnection`
    public struct AllPeople: SWAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.PeopleConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("people", [Person?]?.self),
        .field("pageInfo", PageInfo.self),
      ] }

      /// A list of all of the objects returned in the connection. This is a convenience
      /// field provided for quickly exploring the API; rather than querying for
      /// "{ edges { node } }" when no edge data is needed, this field can be be used
      /// instead. Note that when clients like Relay need to fetch the "cursor" field on
      /// the edge to enable efficient pagination, this shortcut cannot be used, and the
      /// full "{ edges { node } }" version should be used instead.
      public var people: [Person?]? { __data["people"] }
      /// Information to aid in pagination.
      public var pageInfo: PageInfo { __data["pageInfo"] }

      /// AllPeople.Person
      ///
      /// Parent Type: `Person`
      public struct Person: SWAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.Person }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
          .field("filmConnection", FilmConnection?.self),
          .field("birthYear", String?.self),
          .field("homeworld", Homeworld?.self),
          .field("gender", String?.self),
          .field("height", Int?.self),
          .field("hairColor", String?.self),
          .field("eyeColor", String?.self),
          .field("skinColor", String?.self),
          .field("species", Species?.self),
          .field("starshipConnection", StarshipConnection?.self),
          .field("vehicleConnection", VehicleConnection?.self),
          .field("id", SWAPI.ID.self),
        ] }

        /// The name of this person.
        public var name: String? { __data["name"] }
        public var filmConnection: FilmConnection? { __data["filmConnection"] }
        /// The birth year of the person, using the in-universe standard of BBY or ABY -
        /// Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin is
        /// a battle that occurs at the end of Star Wars episode IV: A New Hope.
        public var birthYear: String? { __data["birthYear"] }
        /// A planet that this person was born on or inhabits.
        public var homeworld: Homeworld? { __data["homeworld"] }
        /// The gender of this person. Either "Male", "Female" or "unknown",
        /// "n/a" if the person does not have a gender.
        public var gender: String? { __data["gender"] }
        /// The height of the person in centimeters.
        public var height: Int? { __data["height"] }
        /// The hair color of this person. Will be "unknown" if not known or "n/a" if the
        /// person does not have hair.
        public var hairColor: String? { __data["hairColor"] }
        /// The eye color of this person. Will be "unknown" if not known or "n/a" if the
        /// person does not have an eye.
        public var eyeColor: String? { __data["eyeColor"] }
        /// The skin color of this person.
        public var skinColor: String? { __data["skinColor"] }
        /// The species that this person belongs to, or null if unknown.
        public var species: Species? { __data["species"] }
        public var starshipConnection: StarshipConnection? { __data["starshipConnection"] }
        public var vehicleConnection: VehicleConnection? { __data["vehicleConnection"] }
        /// The ID of an object
        public var id: SWAPI.ID { __data["id"] }

        /// AllPeople.Person.FilmConnection
        ///
        /// Parent Type: `PersonFilmsConnection`
        public struct FilmConnection: SWAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.PersonFilmsConnection }
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

          /// AllPeople.Person.FilmConnection.Film
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

        /// AllPeople.Person.Homeworld
        ///
        /// Parent Type: `Planet`
        public struct Homeworld: SWAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.Planet }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", String?.self),
          ] }

          /// The name of this planet.
          public var name: String? { __data["name"] }
        }

        /// AllPeople.Person.Species
        ///
        /// Parent Type: `Species`
        public struct Species: SWAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.Species }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", String?.self),
          ] }

          /// The name of this species.
          public var name: String? { __data["name"] }
        }

        /// AllPeople.Person.StarshipConnection
        ///
        /// Parent Type: `PersonStarshipsConnection`
        public struct StarshipConnection: SWAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.PersonStarshipsConnection }
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

          /// AllPeople.Person.StarshipConnection.Starship
          ///
          /// Parent Type: `Starship`
          public struct Starship: SWAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.Starship }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String?.self),
            ] }

            /// The name of this starship. The common name, such as "Death Star".
            public var name: String? { __data["name"] }
          }
        }

        /// AllPeople.Person.VehicleConnection
        ///
        /// Parent Type: `PersonVehiclesConnection`
        public struct VehicleConnection: SWAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.PersonVehiclesConnection }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("vehicles", [Vehicle?]?.self),
          ] }

          /// A list of all of the objects returned in the connection. This is a convenience
          /// field provided for quickly exploring the API; rather than querying for
          /// "{ edges { node } }" when no edge data is needed, this field can be be used
          /// instead. Note that when clients like Relay need to fetch the "cursor" field on
          /// the edge to enable efficient pagination, this shortcut cannot be used, and the
          /// full "{ edges { node } }" version should be used instead.
          public var vehicles: [Vehicle?]? { __data["vehicles"] }

          /// AllPeople.Person.VehicleConnection.Vehicle
          ///
          /// Parent Type: `Vehicle`
          public struct Vehicle: SWAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.Vehicle }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String?.self),
            ] }

            /// The name of this vehicle. The common name, such as "Sand Crawler" or "Speeder
            /// bike".
            public var name: String? { __data["name"] }
          }
        }
      }

      /// AllPeople.PageInfo
      ///
      /// Parent Type: `PageInfo`
      public struct PageInfo: SWAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SWAPI.Objects.PageInfo }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("hasNextPage", Bool.self),
          .field("endCursor", String?.self),
        ] }

        /// When paginating forwards, are there more items?
        public var hasNextPage: Bool { __data["hasNextPage"] }
        /// When paginating forwards, the cursor to continue.
        public var endCursor: String? { __data["endCursor"] }
      }
    }
  }
}
