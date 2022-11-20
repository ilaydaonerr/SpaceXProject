import Foundation
import Alamofire



// MARK: - MODEL
struct Flight: Codable {
    let fairings: Fairings?
    let links: Links?
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let net: Bool?
    let window: Int?
    let rocket: Rocket?
    let success: Bool?
    let failures: [Failure]?
    let details: String?
    let crew: [String]?
    let ships: [String]?
    let capsules: [String]?
    let payloads: [String]?
    let launchpad: Launchpad?
    let flightNumber: Int?
    let name: String?
    let dateUTC: String?
    let dateUnix: Int?
    let dateLocal: Date?
    let datePrecision: String?
    let upcoming: Bool?
    let cores: [Core]?
    let autoUpdate: Bool?
    let tbd: Bool?
    let launchLibraryID: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case fairings
        case links
        case staticFireDateUTC
        case staticFireDateUnix
        case net
        case window
        case rocket
        case success
        case failures
        case details
        case crew
        case ships
        case capsules
        case payloads
        case launchpad
        case flightNumber
        case name
        case dateUTC
        case dateUnix
        case dateLocal
        case datePrecision
        case upcoming
        case cores
        case autoUpdate
        case tbd
        case launchLibraryID
        case id
    }
}

// MARK: - Core
struct Core: Codable {
    let core: String?
    let flight: Int?
    let gridfins: Bool?
    let legs: Bool?
    let reused: Bool?
    let landingAttempt: Bool?
    let landingSuccess: Bool?
    let landingType: String?
    let landpad: Landpad?

    enum CodingKeys: String, CodingKey {
        case core
        case flight
        case gridfins
        case legs
        case reused
        case landingAttempt
        case landingSuccess
        case landingType
        case landpad
    }
}

enum LandingType: String, Codable {
    case asds = "ASDS"
    case ocean = "Ocean"
    case rtls = "RTLS"
}

enum Landpad: String, Codable {
    case the5E9E3032383Ecb267A34E7C7 = "5e9e3032383ecb267a34e7c7"
    case the5E9E3032383Ecb554034E7C9 = "5e9e3032383ecb554034e7c9"
    case the5E9E3032383Ecb6Bb234E7CA = "5e9e3032383ecb6bb234e7ca"
    case the5E9E3032383Ecb761634E7Cb = "5e9e3032383ecb761634e7cb"
    case the5E9E3032383Ecb90A834E7C8 = "5e9e3032383ecb90a834e7c8"
    case the5E9E3033383Ecb075134E7CD = "5e9e3033383ecb075134e7cd"
    case the5E9E3033383Ecbb9E534E7Cc = "5e9e3033383ecbb9e534e7cc"
}

enum DatePrecision: String, Codable {
    case day = "day"
    case hour = "hour"
}

// MARK: - Failure
struct Failure: Codable {
    let time: Int?
    let altitude: Int?
    let reason: String?

    enum CodingKeys: String, CodingKey {
        case time
        case altitude
        case reason
    }
}

// MARK: - Fairings
struct Fairings: Codable {
    let reused: Bool?
    let recoveryAttempt: Bool?
    let recovered: Bool?
    let ships: [String]?

    enum CodingKeys: String, CodingKey {
        case reused
        case recoveryAttempt
        case recovered
        case ships
    }
}

enum Launchpad: String, Codable {
    case the5E9E4501F509094Ba4566F84 = "5e9e4501f509094ba4566f84"
    case the5E9E4502F509092B78566F87 = "5e9e4502f509092b78566f87"
    case the5E9E4502F509094188566F88 = "5e9e4502f509094188566f88"
    case the5E9E4502F5090995De566F86 = "5e9e4502f5090995de566f86"
}

// MARK: - Links
struct Links: Codable {
    let patch: Patch?
    let reddit: Reddit?
    let flickr: Flickr?
    let presskit: String?
    let webcast: String?
    let youtubeID: String?
    let article: String?
    let wikipedia: String?

    enum CodingKeys: String, CodingKey {
        case patch
        case reddit
        case flickr
        case presskit
        case webcast
        case youtubeID
        case article
        case wikipedia
    }
}

// MARK: - Flickr
struct Flickr: Codable {
    let small: [JSONAny]?
    let original: [String]?

    enum CodingKeys: String, CodingKey {
        case small
        case original
    }
}

// MARK: - Patch
struct Patch: Codable {
    let small: String?
    let large: String?

    enum CodingKeys: String, CodingKey {
        case small
        case large
    }
}

// MARK: - Reddit
struct Reddit: Codable {
    let campaign: String?
    let launch: String?
    let media: String?
    let recovery: String?

    enum CodingKeys: String, CodingKey {
        case campaign
        case launch
        case media
        case recovery
    }
}

enum Rocket: String, Codable {
    case the5E9D0D95Eda69955F709D1Eb = "5e9d0d95eda69955f709d1eb"
    case the5E9D0D95Eda69973A809D1Ec = "5e9d0d95eda69973a809d1ec"
    case the5E9D0D95Eda69974Db09D1Ed = "5e9d0d95eda69974db09d1ed"
}


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}


