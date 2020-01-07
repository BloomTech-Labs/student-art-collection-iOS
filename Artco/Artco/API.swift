//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ArtcoQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query Artco {
      allArts {
        __typename
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

  public let operationName = "Artco"

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
        GraphQLField("artist_name", type: .scalar(String.self)),
        GraphQLField("price", type: .scalar(Int.self)),
        GraphQLField("date_posted", type: .scalar(String.self)),
        GraphQLField("images", type: .list(.object(Image.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(artistName: String? = nil, price: Int? = nil, datePosted: String? = nil, images: [Image?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Art", "artist_name": artistName, "price": price, "date_posted": datePosted, "images": images.flatMap { (value: [Image?]) -> [ResultMap?] in value.map { (value: Image?) -> ResultMap? in value.flatMap { (value: Image) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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
