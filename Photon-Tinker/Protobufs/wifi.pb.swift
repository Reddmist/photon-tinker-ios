// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: wifi.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum Particle_Ctrl_WiFiAntenna: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case antennaNone // = 0
  case `internal` // = 1
  case external // = 2
  case auto // = 3
  case UNRECOGNIZED(Int)

  init() {
    self = .antennaNone
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .antennaNone
    case 1: self = .internal
    case 2: self = .external
    case 3: self = .auto
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .antennaNone: return 0
    case .internal: return 1
    case .external: return 2
    case .auto: return 3
    case .UNRECOGNIZED(let i): return i
    }
  }

}

enum Particle_Ctrl_WiFiSecurityType: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case unsec // = 0
  case wep // = 1
  case wpa // = 2
  case wpa2 // = 3
  case wpaEnterprise // = 4
  case wpa2Enterprise // = 5
  case unknown // = 255
  case UNRECOGNIZED(Int)

  init() {
    self = .unsec
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .unsec
    case 1: self = .wep
    case 2: self = .wpa
    case 3: self = .wpa2
    case 4: self = .wpaEnterprise
    case 5: self = .wpa2Enterprise
    case 255: self = .unknown
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .unsec: return 0
    case .wep: return 1
    case .wpa: return 2
    case .wpa2: return 3
    case .wpaEnterprise: return 4
    case .wpa2Enterprise: return 5
    case .unknown: return 255
    case .UNRECOGNIZED(let i): return i
    }
  }

}

enum Particle_Ctrl_WiFiSecurityCipher: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case cipherNone // = 0
  case aes // = 1
  case tkip // = 2
  case aesTkip // = 3
  case UNRECOGNIZED(Int)

  init() {
    self = .cipherNone
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .cipherNone
    case 1: self = .aes
    case 2: self = .tkip
    case 3: self = .aesTkip
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .cipherNone: return 0
    case .aes: return 1
    case .tkip: return 2
    case .aesTkip: return 3
    case .UNRECOGNIZED(let i): return i
    }
  }

}

enum Particle_Ctrl_EapType: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case none // = 0
  case tls // = 13
  case peap // = 25
  case UNRECOGNIZED(Int)

  init() {
    self = .none
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .none
    case 13: self = .tls
    case 25: self = .peap
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .none: return 0
    case .tls: return 13
    case .peap: return 25
    case .UNRECOGNIZED(let i): return i
    }
  }

}

/// CTRL_REQUEST_WIFI_GET_ANTENNA = 111
struct Particle_Ctrl_WiFiGetAntennaRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Particle_Ctrl_WiFiGetAntennaReply {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var antenna: Particle_Ctrl_WiFiAntenna = .antennaNone

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// CTRL_REQUEST_WIFI_SET_ANTENNA = 110
struct Particle_Ctrl_WiFiSetAntennaRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var antenna: Particle_Ctrl_WiFiAntenna = .antennaNone

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Particle_Ctrl_WiFiSetAntennaReply {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// CTRL_REQUEST_WIFI_SCAN = 112
struct Particle_Ctrl_WiFiScanRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Particle_Ctrl_WiFiScanReply {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var list: Particle_Ctrl_WiFiAccessPointList {
    get {return _storage._list ?? Particle_Ctrl_WiFiAccessPointList()}
    set {_uniqueStorage()._list = newValue}
  }
  /// Returns true if `list` has been explicitly set.
  var hasList: Bool {return _storage._list != nil}
  /// Clears the value of `list`. Subsequent reads from it will return its default value.
  mutating func clearList() {_storage._list = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

/// CTRL_REQUEST_WIFI_GET_CREDENTIALS = 114
struct Particle_Ctrl_WiFiGetCredentialsRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Particle_Ctrl_WiFiGetCredentialsReply {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var list: Particle_Ctrl_WiFiAccessPointList {
    get {return _storage._list ?? Particle_Ctrl_WiFiAccessPointList()}
    set {_uniqueStorage()._list = newValue}
  }
  /// Returns true if `list` has been explicitly set.
  var hasList: Bool {return _storage._list != nil}
  /// Clears the value of `list`. Subsequent reads from it will return its default value.
  mutating func clearList() {_storage._list = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

/// CTRL_REQUEST_WIFI_SET_CREDENTIALS = 113
struct Particle_Ctrl_WiFiSetCredentialsRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var ap: Particle_Ctrl_WiFiAccessPoint {
    get {return _storage._ap ?? Particle_Ctrl_WiFiAccessPoint()}
    set {_uniqueStorage()._ap = newValue}
  }
  /// Returns true if `ap` has been explicitly set.
  var hasAp: Bool {return _storage._ap != nil}
  /// Clears the value of `ap`. Subsequent reads from it will return its default value.
  mutating func clearAp() {_storage._ap = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Particle_Ctrl_WiFiSetCredentialsReply {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// CTRL_REQUEST_WIFI_CLEAR_CREDENTIALS = 115
struct Particle_Ctrl_WiFiClearCredentialsRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Particle_Ctrl_WiFiClearCredentialsReply {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Particle_Ctrl_WiFiAccessPoint {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var ssid: String = String()

  var bssid: Data = SwiftProtobuf.Internal.emptyData

  var security: Particle_Ctrl_WiFiSecurityType = .unsec

  var cipher: Particle_Ctrl_WiFiSecurityCipher = .cipherNone

  var channel: UInt32 = 0

  var maxDataRate: Int32 = 0

  var rssi: Int32 = 0

  /// Credentials
  var password: String = String()

  var eapType: Particle_Ctrl_EapType = .none

  var innerIdentity: String = String()

  var outerIdentity: String = String()

  var privateKey: Data = SwiftProtobuf.Internal.emptyData

  var clientCertificate: Data = SwiftProtobuf.Internal.emptyData

  var caCertificate: Data = SwiftProtobuf.Internal.emptyData

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Particle_Ctrl_WiFiAccessPointList {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var aps: [Particle_Ctrl_WiFiAccessPoint] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "particle.ctrl"

extension Particle_Ctrl_WiFiAntenna: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "ANTENNA_NONE"),
    1: .same(proto: "INTERNAL"),
    2: .same(proto: "EXTERNAL"),
    3: .same(proto: "AUTO"),
  ]
}

extension Particle_Ctrl_WiFiSecurityType: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "UNSEC"),
    1: .same(proto: "WEP"),
    2: .same(proto: "WPA"),
    3: .same(proto: "WPA2"),
    4: .same(proto: "WPA_ENTERPRISE"),
    5: .same(proto: "WPA2_ENTERPRISE"),
    255: .same(proto: "UNKNOWN"),
  ]
}

extension Particle_Ctrl_WiFiSecurityCipher: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "CIPHER_NONE"),
    1: .same(proto: "AES"),
    2: .same(proto: "TKIP"),
    3: .same(proto: "AES_TKIP"),
  ]
}

extension Particle_Ctrl_EapType: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "EAP_TYPE_NONE"),
    13: .same(proto: "TLS"),
    25: .same(proto: "PEAP"),
  ]
}

extension Particle_Ctrl_WiFiGetAntennaRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiGetAntennaRequest"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiGetAntennaRequest) -> Bool {
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiGetAntennaReply: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiGetAntennaReply"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "antenna"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularEnumField(value: &self.antenna)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.antenna != .antennaNone {
      try visitor.visitSingularEnumField(value: self.antenna, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiGetAntennaReply) -> Bool {
    if self.antenna != other.antenna {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiSetAntennaRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiSetAntennaRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "antenna"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularEnumField(value: &self.antenna)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.antenna != .antennaNone {
      try visitor.visitSingularEnumField(value: self.antenna, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiSetAntennaRequest) -> Bool {
    if self.antenna != other.antenna {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiSetAntennaReply: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiSetAntennaReply"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiSetAntennaReply) -> Bool {
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiScanRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiScanRequest"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiScanRequest) -> Bool {
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiScanReply: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiScanReply"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "list"),
  ]

  fileprivate class _StorageClass {
    var _list: Particle_Ctrl_WiFiAccessPointList? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _list = source._list
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._list)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._list {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiScanReply) -> Bool {
    if _storage !== other._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((_storage, other._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let other_storage = _args.1
        if _storage._list != other_storage._list {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiGetCredentialsRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiGetCredentialsRequest"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiGetCredentialsRequest) -> Bool {
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiGetCredentialsReply: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiGetCredentialsReply"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "list"),
  ]

  fileprivate class _StorageClass {
    var _list: Particle_Ctrl_WiFiAccessPointList? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _list = source._list
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._list)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._list {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiGetCredentialsReply) -> Bool {
    if _storage !== other._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((_storage, other._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let other_storage = _args.1
        if _storage._list != other_storage._list {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiSetCredentialsRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiSetCredentialsRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "ap"),
  ]

  fileprivate class _StorageClass {
    var _ap: Particle_Ctrl_WiFiAccessPoint? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _ap = source._ap
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._ap)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._ap {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiSetCredentialsRequest) -> Bool {
    if _storage !== other._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((_storage, other._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let other_storage = _args.1
        if _storage._ap != other_storage._ap {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiSetCredentialsReply: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiSetCredentialsReply"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiSetCredentialsReply) -> Bool {
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiClearCredentialsRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiClearCredentialsRequest"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiClearCredentialsRequest) -> Bool {
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiClearCredentialsReply: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiClearCredentialsReply"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiClearCredentialsReply) -> Bool {
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiAccessPoint: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiAccessPoint"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "ssid"),
    2: .same(proto: "bssid"),
    3: .same(proto: "security"),
    4: .same(proto: "cipher"),
    5: .same(proto: "channel"),
    6: .standard(proto: "max_data_rate"),
    7: .same(proto: "rssi"),
    8: .same(proto: "password"),
    9: .standard(proto: "eap_type"),
    10: .standard(proto: "inner_identity"),
    11: .standard(proto: "outer_identity"),
    12: .standard(proto: "private_key"),
    13: .standard(proto: "client_certificate"),
    14: .standard(proto: "ca_certificate"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.ssid)
      case 2: try decoder.decodeSingularBytesField(value: &self.bssid)
      case 3: try decoder.decodeSingularEnumField(value: &self.security)
      case 4: try decoder.decodeSingularEnumField(value: &self.cipher)
      case 5: try decoder.decodeSingularUInt32Field(value: &self.channel)
      case 6: try decoder.decodeSingularInt32Field(value: &self.maxDataRate)
      case 7: try decoder.decodeSingularInt32Field(value: &self.rssi)
      case 8: try decoder.decodeSingularStringField(value: &self.password)
      case 9: try decoder.decodeSingularEnumField(value: &self.eapType)
      case 10: try decoder.decodeSingularStringField(value: &self.innerIdentity)
      case 11: try decoder.decodeSingularStringField(value: &self.outerIdentity)
      case 12: try decoder.decodeSingularBytesField(value: &self.privateKey)
      case 13: try decoder.decodeSingularBytesField(value: &self.clientCertificate)
      case 14: try decoder.decodeSingularBytesField(value: &self.caCertificate)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.ssid.isEmpty {
      try visitor.visitSingularStringField(value: self.ssid, fieldNumber: 1)
    }
    if !self.bssid.isEmpty {
      try visitor.visitSingularBytesField(value: self.bssid, fieldNumber: 2)
    }
    if self.security != .unsec {
      try visitor.visitSingularEnumField(value: self.security, fieldNumber: 3)
    }
    if self.cipher != .cipherNone {
      try visitor.visitSingularEnumField(value: self.cipher, fieldNumber: 4)
    }
    if self.channel != 0 {
      try visitor.visitSingularUInt32Field(value: self.channel, fieldNumber: 5)
    }
    if self.maxDataRate != 0 {
      try visitor.visitSingularInt32Field(value: self.maxDataRate, fieldNumber: 6)
    }
    if self.rssi != 0 {
      try visitor.visitSingularInt32Field(value: self.rssi, fieldNumber: 7)
    }
    if !self.password.isEmpty {
      try visitor.visitSingularStringField(value: self.password, fieldNumber: 8)
    }
    if self.eapType != .none {
      try visitor.visitSingularEnumField(value: self.eapType, fieldNumber: 9)
    }
    if !self.innerIdentity.isEmpty {
      try visitor.visitSingularStringField(value: self.innerIdentity, fieldNumber: 10)
    }
    if !self.outerIdentity.isEmpty {
      try visitor.visitSingularStringField(value: self.outerIdentity, fieldNumber: 11)
    }
    if !self.privateKey.isEmpty {
      try visitor.visitSingularBytesField(value: self.privateKey, fieldNumber: 12)
    }
    if !self.clientCertificate.isEmpty {
      try visitor.visitSingularBytesField(value: self.clientCertificate, fieldNumber: 13)
    }
    if !self.caCertificate.isEmpty {
      try visitor.visitSingularBytesField(value: self.caCertificate, fieldNumber: 14)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiAccessPoint) -> Bool {
    if self.ssid != other.ssid {return false}
    if self.bssid != other.bssid {return false}
    if self.security != other.security {return false}
    if self.cipher != other.cipher {return false}
    if self.channel != other.channel {return false}
    if self.maxDataRate != other.maxDataRate {return false}
    if self.rssi != other.rssi {return false}
    if self.password != other.password {return false}
    if self.eapType != other.eapType {return false}
    if self.innerIdentity != other.innerIdentity {return false}
    if self.outerIdentity != other.outerIdentity {return false}
    if self.privateKey != other.privateKey {return false}
    if self.clientCertificate != other.clientCertificate {return false}
    if self.caCertificate != other.caCertificate {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_WiFiAccessPointList: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".WiFiAccessPointList"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "aps"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.aps)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.aps.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.aps, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_WiFiAccessPointList) -> Bool {
    if self.aps != other.aps {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}