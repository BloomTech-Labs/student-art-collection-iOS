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
        school {
          __typename
          zipcode
        }
        category {
          __typename
          id
          category
        }
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
        GraphQLField("school", type: .object(School.selections)),
        GraphQLField("category", type: .object(Category.selections)),
        GraphQLField("artist_name", type: .scalar(String.self)),
        GraphQLField("price", type: .scalar(Int.self)),
        GraphQLField("date_posted", type: .scalar(String.self)),
        GraphQLField("images", type: .list(.object(Image.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, school: School? = nil, category: Category? = nil, artistName: String? = nil, price: Int? = nil, datePosted: String? = nil, images: [Image?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Art", "id": id, "school": school.flatMap { (value: School) -> ResultMap in value.resultMap }, "category": category.flatMap { (value: Category) -> ResultMap in value.resultMap }, "artist_name": artistName, "price": price, "date_posted": datePosted, "images": images.flatMap { (value: [Image?]) -> [ResultMap?] in value.map { (value: Image?) -> ResultMap? in value.flatMap { (value: Image) -> ResultMap in value.resultMap } } }])
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

      public var school: School? {
        get {
          return (resultMap["school"] as? ResultMap).flatMap { School(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "school")
        }
      }

      public var category: Category? {
        get {
          return (resultMap["category"] as? ResultMap).flatMap { Category(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "category")
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

      public struct School: GraphQLSelectionSet {
        public static let possibleTypes = ["School"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("zipcode", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(zipcode: String) {
          self.init(unsafeResultMap: ["__typename": "School", "zipcode": zipcode])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

      public struct Category: GraphQLSelectionSet {
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

public final class SchoolByFirebaseIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query SchoolByFirebaseID($school_id: ID!) {
      schoolBySchoolId(school_id: $school_id) {
        __typename
        id
      }
    }
    """

  public let operationName = "SchoolByFirebaseID"

  public var school_id: GraphQLID

  public init(school_id: GraphQLID) {
    self.school_id = school_id
  }

  public var variables: GraphQLMap? {
    return ["school_id": school_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("schoolBySchoolId", arguments: ["school_id": GraphQLVariable("school_id")], type: .nonNull(.object(SchoolBySchoolId.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(schoolBySchoolId: SchoolBySchoolId) {
      self.init(unsafeResultMap: ["__typename": "Query", "schoolBySchoolId": schoolBySchoolId.resultMap])
    }

    public var schoolBySchoolId: SchoolBySchoolId {
      get {
        return SchoolBySchoolId(unsafeResultMap: resultMap["schoolBySchoolId"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "schoolBySchoolId")
      }
    }

    public struct SchoolBySchoolId: GraphQLSelectionSet {
      public static let possibleTypes = ["School"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID) {
        self.init(unsafeResultMap: ["__typename": "School", "id": id])
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

public final class ArtBySchoolQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query ArtBySchool($school_id: ID!) {
      artBySchool(school_id: $school_id) {
        __typename
        id
        school_id
        price
        sold
        title
        artist_name
        description
        date_posted
        images {
          __typename
          image_url
        }
      }
    }
    """

  public let operationName = "ArtBySchool"

  public var school_id: GraphQLID

  public init(school_id: GraphQLID) {
    self.school_id = school_id
  }

  public var variables: GraphQLMap? {
    return ["school_id": school_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("artBySchool", arguments: ["school_id": GraphQLVariable("school_id")], type: .nonNull(.list(.nonNull(.object(ArtBySchool.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(artBySchool: [ArtBySchool]) {
      self.init(unsafeResultMap: ["__typename": "Query", "artBySchool": artBySchool.map { (value: ArtBySchool) -> ResultMap in value.resultMap }])
    }

    public var artBySchool: [ArtBySchool] {
      get {
        return (resultMap["artBySchool"] as! [ResultMap]).map { (value: ResultMap) -> ArtBySchool in ArtBySchool(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: ArtBySchool) -> ResultMap in value.resultMap }, forKey: "artBySchool")
      }
    }

    public struct ArtBySchool: GraphQLSelectionSet {
      public static let possibleTypes = ["Art"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("school_id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("price", type: .scalar(Int.self)),
        GraphQLField("sold", type: .scalar(Bool.self)),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("artist_name", type: .scalar(String.self)),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("date_posted", type: .scalar(String.self)),
        GraphQLField("images", type: .list(.object(Image.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, schoolId: GraphQLID, price: Int? = nil, sold: Bool? = nil, title: String? = nil, artistName: String? = nil, description: String? = nil, datePosted: String? = nil, images: [Image?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Art", "id": id, "school_id": schoolId, "price": price, "sold": sold, "title": title, "artist_name": artistName, "description": description, "date_posted": datePosted, "images": images.flatMap { (value: [Image?]) -> [ResultMap?] in value.map { (value: Image?) -> ResultMap? in value.flatMap { (value: Image) -> ResultMap in value.resultMap } } }])
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

      public var schoolId: GraphQLID {
        get {
          return resultMap["school_id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "school_id")
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

      public var sold: Bool? {
        get {
          return resultMap["sold"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "sold")
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

public final class AddSchoolMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation AddSchool($school_id: ID!, $school_name: String!, $email: String!, $address: String!, $city: String!, $zipcode: String!) {
      addSchool(school_id: $school_id, school_name: $school_name, email: $email, address: $address, city: $city, zipcode: $zipcode) {
        __typename
        id
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

  public var school_id: GraphQLID
  public var school_name: String
  public var email: String
  public var address: String
  public var city: String
  public var zipcode: String

  public init(school_id: GraphQLID, school_name: String, email: String, address: String, city: String, zipcode: String) {
    self.school_id = school_id
    self.school_name = school_name
    self.email = email
    self.address = address
    self.city = city
    self.zipcode = zipcode
  }

  public var variables: GraphQLMap? {
    return ["school_id": school_id, "school_name": school_name, "email": email, "address": address, "city": city, "zipcode": zipcode]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addSchool", arguments: ["school_id": GraphQLVariable("school_id"), "school_name": GraphQLVariable("school_name"), "email": GraphQLVariable("email"), "address": GraphQLVariable("address"), "city": GraphQLVariable("city"), "zipcode": GraphQLVariable("zipcode")], type: .nonNull(.object(AddSchool.selections))),
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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
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

      public init(id: GraphQLID, schoolId: GraphQLID, schoolName: String, email: String, address: String, city: String, zipcode: String) {
        self.init(unsafeResultMap: ["__typename": "School", "id": id, "school_id": schoolId, "school_name": schoolName, "email": email, "address": address, "city": city, "zipcode": zipcode])
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

public final class AddArtMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation AddArt($category: ID!, $school_id: ID!, $price: Int, $title: String, $artist_name: String, $description: String, $image_url: String!) {
      addArt(category: $category, school_id: $school_id, price: $price, title: $title, artist_name: $artist_name, description: $description, image_url: $image_url) {
        __typename
        id
        school_id
        price
        sold
        title
        artist_name
        description
        date_posted
      }
    }
    """

  public let operationName = "AddArt"

  public var category: GraphQLID
  public var school_id: GraphQLID
  public var price: Int?
  public var title: String?
  public var artist_name: String?
  public var description: String?
  public var image_url: String

  public init(category: GraphQLID, school_id: GraphQLID, price: Int? = nil, title: String? = nil, artist_name: String? = nil, description: String? = nil, image_url: String) {
    self.category = category
    self.school_id = school_id
    self.price = price
    self.title = title
    self.artist_name = artist_name
    self.description = description
    self.image_url = image_url
  }

  public var variables: GraphQLMap? {
    return ["category": category, "school_id": school_id, "price": price, "title": title, "artist_name": artist_name, "description": description, "image_url": image_url]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addArt", arguments: ["category": GraphQLVariable("category"), "school_id": GraphQLVariable("school_id"), "price": GraphQLVariable("price"), "title": GraphQLVariable("title"), "artist_name": GraphQLVariable("artist_name"), "description": GraphQLVariable("description"), "image_url": GraphQLVariable("image_url")], type: .object(AddArt.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addArt: AddArt? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addArt": addArt.flatMap { (value: AddArt) -> ResultMap in value.resultMap }])
    }

    public var addArt: AddArt? {
      get {
        return (resultMap["addArt"] as? ResultMap).flatMap { AddArt(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "addArt")
      }
    }

    public struct AddArt: GraphQLSelectionSet {
      public static let possibleTypes = ["Art"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("school_id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("price", type: .scalar(Int.self)),
        GraphQLField("sold", type: .scalar(Bool.self)),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("artist_name", type: .scalar(String.self)),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("date_posted", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, schoolId: GraphQLID, price: Int? = nil, sold: Bool? = nil, title: String? = nil, artistName: String? = nil, description: String? = nil, datePosted: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Art", "id": id, "school_id": schoolId, "price": price, "sold": sold, "title": title, "artist_name": artistName, "description": description, "date_posted": datePosted])
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

      public var schoolId: GraphQLID {
        get {
          return resultMap["school_id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "school_id")
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

      public var sold: Bool? {
        get {
          return resultMap["sold"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "sold")
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

      public var datePosted: String? {
        get {
          return resultMap["date_posted"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "date_posted")
        }
      }
    }
  }
}

public final class AddImageMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation AddImage($image_url: String, $art_id: Int) {
      addImage(image_url: $image_url, art_id: $art_id) {
        __typename
        id
        image_url
        art_id
      }
    }
    """

  public let operationName = "AddImage"

  public var image_url: String?
  public var art_id: Int?

  public init(image_url: String? = nil, art_id: Int? = nil) {
    self.image_url = image_url
    self.art_id = art_id
  }

  public var variables: GraphQLMap? {
    return ["image_url": image_url, "art_id": art_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addImage", arguments: ["image_url": GraphQLVariable("image_url"), "art_id": GraphQLVariable("art_id")], type: .nonNull(.object(AddImage.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addImage: AddImage) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addImage": addImage.resultMap])
    }

    public var addImage: AddImage {
      get {
        return AddImage(unsafeResultMap: resultMap["addImage"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "addImage")
      }
    }

    public struct AddImage: GraphQLSelectionSet {
      public static let possibleTypes = ["Image"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("image_url", type: .scalar(String.self)),
        GraphQLField("art_id", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, imageUrl: String? = nil, artId: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "Image", "id": id, "image_url": imageUrl, "art_id": artId])
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

      public var imageUrl: String? {
        get {
          return resultMap["image_url"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image_url")
        }
      }

      public var artId: Int? {
        get {
          return resultMap["art_id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "art_id")
        }
      }
    }
  }
}

public final class UpdateArtMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation UpdateArt($id: ID!, $price: Int, $title: String, $artist_name: String, $description: String) {
      updateArt(id: $id, price: $price, title: $title, artist_name: $artist_name, description: $description) {
        __typename
        id
        school_id
        price
        sold
        title
        artist_name
        description
        date_posted
      }
    }
    """

  public let operationName = "UpdateArt"

  public var id: GraphQLID
  public var price: Int?
  public var title: String?
  public var artist_name: String?
  public var description: String?

  public init(id: GraphQLID, price: Int? = nil, title: String? = nil, artist_name: String? = nil, description: String? = nil) {
    self.id = id
    self.price = price
    self.title = title
    self.artist_name = artist_name
    self.description = description
  }

  public var variables: GraphQLMap? {
    return ["id": id, "price": price, "title": title, "artist_name": artist_name, "description": description]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateArt", arguments: ["id": GraphQLVariable("id"), "price": GraphQLVariable("price"), "title": GraphQLVariable("title"), "artist_name": GraphQLVariable("artist_name"), "description": GraphQLVariable("description")], type: .nonNull(.object(UpdateArt.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateArt: UpdateArt) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateArt": updateArt.resultMap])
    }

    public var updateArt: UpdateArt {
      get {
        return UpdateArt(unsafeResultMap: resultMap["updateArt"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "updateArt")
      }
    }

    public struct UpdateArt: GraphQLSelectionSet {
      public static let possibleTypes = ["Art"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("school_id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("price", type: .scalar(Int.self)),
        GraphQLField("sold", type: .scalar(Bool.self)),
        GraphQLField("title", type: .scalar(String.self)),
        GraphQLField("artist_name", type: .scalar(String.self)),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("date_posted", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, schoolId: GraphQLID, price: Int? = nil, sold: Bool? = nil, title: String? = nil, artistName: String? = nil, description: String? = nil, datePosted: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Art", "id": id, "school_id": schoolId, "price": price, "sold": sold, "title": title, "artist_name": artistName, "description": description, "date_posted": datePosted])
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

      public var schoolId: GraphQLID {
        get {
          return resultMap["school_id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "school_id")
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

      public var sold: Bool? {
        get {
          return resultMap["sold"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "sold")
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

      public var datePosted: String? {
        get {
          return resultMap["date_posted"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "date_posted")
        }
      }
    }
  }
}

public final class UpdateImageMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation UpdateImage($id: ID!, $image_url: String, $art_id: Int) {
      updateImage(id: $id, image_url: $image_url, art_id: $art_id) {
        __typename
        id
        image_url
        art_id
      }
    }
    """

  public let operationName = "UpdateImage"

  public var id: GraphQLID
  public var image_url: String?
  public var art_id: Int?

  public init(id: GraphQLID, image_url: String? = nil, art_id: Int? = nil) {
    self.id = id
    self.image_url = image_url
    self.art_id = art_id
  }

  public var variables: GraphQLMap? {
    return ["id": id, "image_url": image_url, "art_id": art_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateImage", arguments: ["id": GraphQLVariable("id"), "image_url": GraphQLVariable("image_url"), "art_id": GraphQLVariable("art_id")], type: .nonNull(.object(UpdateImage.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateImage: UpdateImage) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateImage": updateImage.resultMap])
    }

    public var updateImage: UpdateImage {
      get {
        return UpdateImage(unsafeResultMap: resultMap["updateImage"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "updateImage")
      }
    }

    public struct UpdateImage: GraphQLSelectionSet {
      public static let possibleTypes = ["Image"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("image_url", type: .scalar(String.self)),
        GraphQLField("art_id", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, imageUrl: String? = nil, artId: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "Image", "id": id, "image_url": imageUrl, "art_id": artId])
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

      public var imageUrl: String? {
        get {
          return resultMap["image_url"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image_url")
        }
      }

      public var artId: Int? {
        get {
          return resultMap["art_id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "art_id")
        }
      }
    }
  }
}
