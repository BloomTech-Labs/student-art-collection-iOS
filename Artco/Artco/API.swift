//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class AllArtQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query AllArt {
      allArts {
        __typename
        id
        artist_name
        price
        date_posted
        images {
          __typename
          image_url
        }
      }
    }
    """

  public let operationName = "AllArt"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allArts", type: .nonNull(.list(.nonNull(.object(AllArt.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allArts: [AllArt]) {
      self.init(unsafeResultMap: ["__typename": "Query", "allArts": allArts.map { (value: AllArt) -> ResultMap in value.resultMap }])
    }

    public var allArts: [AllArt] {
      get {
        return (resultMap["allArts"] as! [ResultMap]).map { (value: ResultMap) -> AllArt in AllArt(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AllArt) -> ResultMap in value.resultMap }, forKey: "allArts")
      }
    }

    public struct AllArt: GraphQLSelectionSet {
      public static let possibleTypes = ["Art"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("artist_name", type: .scalar(String.self)),
        GraphQLField("price", type: .scalar(Int.self)),
        GraphQLField("date_posted", type: .scalar(String.self)),
        GraphQLField("images", type: .list(.object(Image.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, artistName: String? = nil, price: Int? = nil, datePosted: String? = nil, images: [Image?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Art", "id": id, "artist_name": artistName, "price": price, "date_posted": datePosted, "images": images.flatMap { (value: [Image?]) -> [ResultMap?] in value.map { (value: Image?) -> ResultMap? in value.flatMap { (value: Image) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var artistName: String? {
        get {
          return resultMap["artist_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "artist_name")
        }
      }

      public var price: Int? {
        get {
          return resultMap["price"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "price")
        }
      }

      public var datePosted: String? {
        get {
          return resultMap["date_posted"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "date_posted")
        }
      }

      public var images: [Image?]? {
        get {
          return (resultMap["images"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Image?] in value.map { (value: ResultMap?) -> Image? in value.flatMap { (value: ResultMap) -> Image in Image(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Image?]) -> [ResultMap?] in value.map { (value: Image?) -> ResultMap? in value.flatMap { (value: Image) -> ResultMap in value.resultMap } } }, forKey: "images")
        }
      }

      public struct Image: GraphQLSelectionSet {
        public static let possibleTypes = ["Image"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("image_url", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(imageUrl: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Image", "image_url": imageUrl])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var imageUrl: String? {
          get {
            return resultMap["image_url"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "image_url")
          }
        }
      }
    }
  }
}

public final class AllCategoriesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query AllCategories {
      allCategories {
        __typename
        id
        category
      }
    }
    """

  public let operationName = "AllCategories"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allCategories", type: .nonNull(.list(.nonNull(.object(AllCategory.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allCategories: [AllCategory]) {
      self.init(unsafeResultMap: ["__typename": "Query", "allCategories": allCategories.map { (value: AllCategory) -> ResultMap in value.resultMap }])
    }

    public var allCategories: [AllCategory] {
      get {
        return (resultMap["allCategories"] as! [ResultMap]).map { (value: ResultMap) -> AllCategory in AllCategory(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AllCategory) -> ResultMap in value.resultMap }, forKey: "allCategories")
      }
    }

    public struct AllCategory: GraphQLSelectionSet {
      public static let possibleTypes = ["Category"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("category", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, category: String) {
        self.init(unsafeResultMap: ["__typename": "Category", "id": id, "category": category])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var category: String {
        get {
          return resultMap["category"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "category")
        }
      }
    }
  }
}

public final class AllSchoolsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query AllSchools {
      allSchools {
        __typename
        email
      }
    }
    """

  public let operationName = "AllSchools"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allSchools", type: .nonNull(.list(.nonNull(.object(AllSchool.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allSchools: [AllSchool]) {
      self.init(unsafeResultMap: ["__typename": "Query", "allSchools": allSchools.map { (value: AllSchool) -> ResultMap in value.resultMap }])
    }

    public var allSchools: [AllSchool] {
      get {
        return (resultMap["allSchools"] as! [ResultMap]).map { (value: ResultMap) -> AllSchool in AllSchool(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AllSchool) -> ResultMap in value.resultMap }, forKey: "allSchools")
      }
    }

    public struct AllSchool: GraphQLSelectionSet {
      public static let possibleTypes = ["School"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("email", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(email: String) {
        self.init(unsafeResultMap: ["__typename": "School", "email": email])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }
    }
  }
}

public final class ArtQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query Art($id: ID!) {
      art(id: $id) {
        __typename
        price
        title
        artist_name
        description
        sold
        images {
          __typename
          image_url
        }
      }
    }
    """

  public let operationName = "Art"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("art", arguments: ["id": GraphQLVariable("id")], type: .nonNull(.object(Art.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(art: Art) {
      self.init(unsafeResultMap: ["__typename": "Query", "art": art.resultMap])
    }

    public var art: Art {
      get {
        return Art(unsafeResultMap: resultMap["art"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "art")
      }
    }

    public struct Art: GraphQLSelectionSet {
      public static let possibleTypes = ["Art"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("price", type: .scalar(Int.self)),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("artist_name", type: .scalar(String.self)),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("sold", type: .scalar(Bool.self)),
        GraphQLField("images", type: .list(.object(Image.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(price: Int? = nil, title: String? = nil, artistName: String? = nil, description: String? = nil, sold: Bool? = nil, images: [Image?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Art", "price": price, "title": title, "artist_name": artistName, "description": description, "sold": sold, "images": images.flatMap { (value: [Image?]) -> [ResultMap?] in value.map { (value: Image?) -> ResultMap? in value.flatMap { (value: Image) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var price: Int? {
        get {
          return resultMap["price"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "price")
        }
      }

      public var title: String? {
        get {
          return resultMap["title"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var artistName: String? {
        get {
          return resultMap["artist_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "artist_name")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var sold: Bool? {
        get {
          return resultMap["sold"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "sold")
        }
      }

      public var images: [Image?]? {
        get {
          return (resultMap["images"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Image?] in value.map { (value: ResultMap?) -> Image? in value.flatMap { (value: ResultMap) -> Image in Image(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Image?]) -> [ResultMap?] in value.map { (value: Image?) -> ResultMap? in value.flatMap { (value: Image) -> ResultMap in value.resultMap } } }, forKey: "images")
        }
      }

      public struct Image: GraphQLSelectionSet {
        public static let possibleTypes = ["Image"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("image_url", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(imageUrl: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Image", "image_url": imageUrl])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var imageUrl: String? {
          get {
            return resultMap["image_url"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "image_url")
          }
        }
      }
    }
  }
}

public final class AddSchoolMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation AddSchool {
      addSchool(school_id: "ID", school_name: "String", email: "String", address: "String", city: "String", zipcode: "String") {
        __typename
        school_id
        school_name
        email
        address
        city
        zipcode
      }
    }
    """

  public let operationName = "AddSchool"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addSchool", arguments: ["school_id": "ID", "school_name": "String", "email": "String", "address": "String", "city": "String", "zipcode": "String"], type: .nonNull(.object(AddSchool.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addSchool: AddSchool) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addSchool": addSchool.resultMap])
    }

    public var addSchool: AddSchool {
      get {
        return AddSchool(unsafeResultMap: resultMap["addSchool"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "addSchool")
      }
    }

    public struct AddSchool: GraphQLSelectionSet {
      public static let possibleTypes = ["School"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("school_id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("school_name", type: .nonNull(.scalar(String.self))),
        GraphQLField("email", type: .nonNull(.scalar(String.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("city", type: .nonNull(.scalar(String.self))),
        GraphQLField("zipcode", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(schoolId: GraphQLID, schoolName: String, email: String, address: String, city: String, zipcode: String) {
        self.init(unsafeResultMap: ["__typename": "School", "school_id": schoolId, "school_name": schoolName, "email": email, "address": address, "city": city, "zipcode": zipcode])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var schoolId: GraphQLID {
        get {
          return resultMap["school_id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "school_id")
        }
      }

      public var schoolName: String {
        get {
          return resultMap["school_name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "school_name")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var address: String {
        get {
          return resultMap["address"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "address")
        }
      }

      public var city: String {
        get {
          return resultMap["city"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "city")
        }
      }

      public var zipcode: String {
        get {
          return resultMap["zipcode"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "zipcode")
        }
      }
    }
  }
}
