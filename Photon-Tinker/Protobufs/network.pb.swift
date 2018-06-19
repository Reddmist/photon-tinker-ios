// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: network.proto
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

enum Particle_Ctrl_NetworkState: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case networkStatusNone // = 0
  case down // = 1
  case up // = 2
  case UNRECOGNIZED(Int)

  init() {
    self = .networkStatusNone
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .networkStatusNone
    case 1: self = .down
    case 2: self = .up
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .networkStatusNone: return 0
    case .down: return 1
    case .up: return 2
    case .UNRECOGNIZED(let i): return i
    }
  }

}

/// CTRL_REQUEST_NETWORK_GET_STATUS = 122
struct Particle_Ctrl_NetworkGetStatusRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var interface: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Particle_Ctrl_NetworkGetStatusReply {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var config: Particle_Ctrl_NetworkConfiguration {
    get {return _storage._config ?? Particle_Ctrl_NetworkConfiguration()}
    set {_uniqueStorage()._config = newValue}
  }
  /// Returns true if `config` has been explicitly set.
  var hasConfig: Bool {return _storage._config != nil}
  /// Clears the value of `config`. Subsequent reads from it will return its default value.
  mutating func clearConfig() {_storage._config = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

/// CTRL_REQUEST_NETWORK_GET_CONFIGURATION = 120
struct Particle_Ctrl_NetworkGetConfigurationRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var interface: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Particle_Ctrl_NetworkGetConfigurationReply {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var config: Particle_Ctrl_NetworkConfiguration {
    get {return _storage._config ?? Particle_Ctrl_NetworkConfiguration()}
    set {_uniqueStorage()._config = newValue}
  }
  /// Returns true if `config` has been explicitly set.
  var hasConfig: Bool {return _storage._config != nil}
  /// Clears the value of `config`. Subsequent reads from it will return its default value.
  mutating func clearConfig() {_storage._config = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

/// CTRL_REQUEST_NETWORK_SET_CONFIGURATION = 121
struct Particle_Ctrl_NetworkSetConfigurationRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var config: Particle_Ctrl_NetworkConfiguration {
    get {return _storage._config ?? Particle_Ctrl_NetworkConfiguration()}
    set {_uniqueStorage()._config = newValue}
  }
  /// Returns true if `config` has been explicitly set.
  var hasConfig: Bool {return _storage._config != nil}
  /// Clears the value of `config`. Subsequent reads from it will return its default value.
  mutating func clearConfig() {_storage._config = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Particle_Ctrl_NetworkSetConfigurationReply {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Particle_Ctrl_IPConfiguration {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var type: Particle_Ctrl_IPConfiguration.TypeEnum {
    get {return _storage._type}
    set {_uniqueStorage()._type = newValue}
  }

  var address: Particle_Ctrl_IPAddress {
    get {return _storage._address ?? Particle_Ctrl_IPAddress()}
    set {_uniqueStorage()._address = newValue}
  }
  /// Returns true if `address` has been explicitly set.
  var hasAddress: Bool {return _storage._address != nil}
  /// Clears the value of `address`. Subsequent reads from it will return its default value.
  mutating func clearAddress() {_storage._address = nil}

  var netmask: Particle_Ctrl_IPAddress {
    get {return _storage._netmask ?? Particle_Ctrl_IPAddress()}
    set {_uniqueStorage()._netmask = newValue}
  }
  /// Returns true if `netmask` has been explicitly set.
  var hasNetmask: Bool {return _storage._netmask != nil}
  /// Clears the value of `netmask`. Subsequent reads from it will return its default value.
  mutating func clearNetmask() {_storage._netmask = nil}

  var gateway: Particle_Ctrl_IPAddress {
    get {return _storage._gateway ?? Particle_Ctrl_IPAddress()}
    set {_uniqueStorage()._gateway = newValue}
  }
  /// Returns true if `gateway` has been explicitly set.
  var hasGateway: Bool {return _storage._gateway != nil}
  /// Clears the value of `gateway`. Subsequent reads from it will return its default value.
  mutating func clearGateway() {_storage._gateway = nil}

  var dhcpServer: Particle_Ctrl_IPAddress {
    get {return _storage._dhcpServer ?? Particle_Ctrl_IPAddress()}
    set {_uniqueStorage()._dhcpServer = newValue}
  }
  /// Returns true if `dhcpServer` has been explicitly set.
  var hasDhcpServer: Bool {return _storage._dhcpServer != nil}
  /// Clears the value of `dhcpServer`. Subsequent reads from it will return its default value.
  mutating func clearDhcpServer() {_storage._dhcpServer = nil}

  var hostname: String {
    get {return _storage._hostname}
    set {_uniqueStorage()._hostname = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum TypeEnum: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case none // = 0
    case dhcp // = 1
    case `static` // = 2
    case UNRECOGNIZED(Int)

    init() {
      self = .none
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .none
      case 1: self = .dhcp
      case 2: self = .static
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    var rawValue: Int {
      switch self {
      case .none: return 0
      case .dhcp: return 1
      case .static: return 2
      case .UNRECOGNIZED(let i): return i
      }
    }

  }

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Particle_Ctrl_DNSConfiguration {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var servers: [Particle_Ctrl_IPAddress] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Particle_Ctrl_NetworkConfiguration {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var interface: Int32 {
    get {return _storage._interface}
    set {_uniqueStorage()._interface = newValue}
  }

  var state: Particle_Ctrl_NetworkState {
    get {return _storage._state}
    set {_uniqueStorage()._state = newValue}
  }

  var name: String {
    get {return _storage._name}
    set {_uniqueStorage()._name = newValue}
  }

  var mac: Data {
    get {return _storage._mac}
    set {_uniqueStorage()._mac = newValue}
  }

  var ipconfig: Particle_Ctrl_IPConfiguration {
    get {return _storage._ipconfig ?? Particle_Ctrl_IPConfiguration()}
    set {_uniqueStorage()._ipconfig = newValue}
  }
  /// Returns true if `ipconfig` has been explicitly set.
  var hasIpconfig: Bool {return _storage._ipconfig != nil}
  /// Clears the value of `ipconfig`. Subsequent reads from it will return its default value.
  mutating func clearIpconfig() {_storage._ipconfig = nil}

  var dnsconfig: Particle_Ctrl_DNSConfiguration {
    get {return _storage._dnsconfig ?? Particle_Ctrl_DNSConfiguration()}
    set {_uniqueStorage()._dnsconfig = newValue}
  }
  /// Returns true if `dnsconfig` has been explicitly set.
  var hasDnsconfig: Bool {return _storage._dnsconfig != nil}
  /// Clears the value of `dnsconfig`. Subsequent reads from it will return its default value.
  mutating func clearDnsconfig() {_storage._dnsconfig = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "particle.ctrl"

extension Particle_Ctrl_NetworkState: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "NETWORK_STATUS_NONE"),
    1: .same(proto: "DOWN"),
    2: .same(proto: "UP"),
  ]
}

extension Particle_Ctrl_NetworkGetStatusRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NetworkGetStatusRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "interface"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt32Field(value: &self.interface)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.interface != 0 {
      try visitor.visitSingularInt32Field(value: self.interface, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_NetworkGetStatusRequest) -> Bool {
    if self.interface != other.interface {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_NetworkGetStatusReply: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NetworkGetStatusReply"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "config"),
  ]

  fileprivate class _StorageClass {
    var _config: Particle_Ctrl_NetworkConfiguration? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _config = source._config
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
        case 1: try decoder.decodeSingularMessageField(value: &_storage._config)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._config {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_NetworkGetStatusReply) -> Bool {
    if _storage !== other._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((_storage, other._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let other_storage = _args.1
        if _storage._config != other_storage._config {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_NetworkGetConfigurationRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NetworkGetConfigurationRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "interface"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt32Field(value: &self.interface)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.interface != 0 {
      try visitor.visitSingularInt32Field(value: self.interface, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_NetworkGetConfigurationRequest) -> Bool {
    if self.interface != other.interface {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_NetworkGetConfigurationReply: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NetworkGetConfigurationReply"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "config"),
  ]

  fileprivate class _StorageClass {
    var _config: Particle_Ctrl_NetworkConfiguration? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _config = source._config
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
        case 1: try decoder.decodeSingularMessageField(value: &_storage._config)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._config {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_NetworkGetConfigurationReply) -> Bool {
    if _storage !== other._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((_storage, other._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let other_storage = _args.1
        if _storage._config != other_storage._config {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_NetworkSetConfigurationRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NetworkSetConfigurationRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "config"),
  ]

  fileprivate class _StorageClass {
    var _config: Particle_Ctrl_NetworkConfiguration? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _config = source._config
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
        case 1: try decoder.decodeSingularMessageField(value: &_storage._config)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._config {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_NetworkSetConfigurationRequest) -> Bool {
    if _storage !== other._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((_storage, other._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let other_storage = _args.1
        if _storage._config != other_storage._config {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_NetworkSetConfigurationReply: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NetworkSetConfigurationReply"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_NetworkSetConfigurationReply) -> Bool {
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_IPConfiguration: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".IPConfiguration"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "type"),
    2: .same(proto: "address"),
    3: .same(proto: "netmask"),
    4: .same(proto: "gateway"),
    5: .standard(proto: "dhcp_server"),
    6: .same(proto: "hostname"),
  ]

  fileprivate class _StorageClass {
    var _type: Particle_Ctrl_IPConfiguration.TypeEnum = .none
    var _address: Particle_Ctrl_IPAddress? = nil
    var _netmask: Particle_Ctrl_IPAddress? = nil
    var _gateway: Particle_Ctrl_IPAddress? = nil
    var _dhcpServer: Particle_Ctrl_IPAddress? = nil
    var _hostname: String = String()

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _type = source._type
      _address = source._address
      _netmask = source._netmask
      _gateway = source._gateway
      _dhcpServer = source._dhcpServer
      _hostname = source._hostname
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
        case 1: try decoder.decodeSingularEnumField(value: &_storage._type)
        case 2: try decoder.decodeSingularMessageField(value: &_storage._address)
        case 3: try decoder.decodeSingularMessageField(value: &_storage._netmask)
        case 4: try decoder.decodeSingularMessageField(value: &_storage._gateway)
        case 5: try decoder.decodeSingularMessageField(value: &_storage._dhcpServer)
        case 6: try decoder.decodeSingularStringField(value: &_storage._hostname)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if _storage._type != .none {
        try visitor.visitSingularEnumField(value: _storage._type, fieldNumber: 1)
      }
      if let v = _storage._address {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
      if let v = _storage._netmask {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      }
      if let v = _storage._gateway {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
      }
      if let v = _storage._dhcpServer {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
      }
      if !_storage._hostname.isEmpty {
        try visitor.visitSingularStringField(value: _storage._hostname, fieldNumber: 6)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_IPConfiguration) -> Bool {
    if _storage !== other._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((_storage, other._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let other_storage = _args.1
        if _storage._type != other_storage._type {return false}
        if _storage._address != other_storage._address {return false}
        if _storage._netmask != other_storage._netmask {return false}
        if _storage._gateway != other_storage._gateway {return false}
        if _storage._dhcpServer != other_storage._dhcpServer {return false}
        if _storage._hostname != other_storage._hostname {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_IPConfiguration.TypeEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "NONE"),
    1: .same(proto: "DHCP"),
    2: .same(proto: "STATIC"),
  ]
}

extension Particle_Ctrl_DNSConfiguration: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".DNSConfiguration"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "servers"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.servers)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.servers.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.servers, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_DNSConfiguration) -> Bool {
    if self.servers != other.servers {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_NetworkConfiguration: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NetworkConfiguration"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "interface"),
    2: .same(proto: "state"),
    3: .same(proto: "name"),
    4: .same(proto: "mac"),
    5: .same(proto: "ipconfig"),
    6: .same(proto: "dnsconfig"),
  ]

  fileprivate class _StorageClass {
    var _interface: Int32 = 0
    var _state: Particle_Ctrl_NetworkState = .networkStatusNone
    var _name: String = String()
    var _mac: Data = SwiftProtobuf.Internal.emptyData
    var _ipconfig: Particle_Ctrl_IPConfiguration? = nil
    var _dnsconfig: Particle_Ctrl_DNSConfiguration? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _interface = source._interface
      _state = source._state
      _name = source._name
      _mac = source._mac
      _ipconfig = source._ipconfig
      _dnsconfig = source._dnsconfig
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
        case 1: try decoder.decodeSingularInt32Field(value: &_storage._interface)
        case 2: try decoder.decodeSingularEnumField(value: &_storage._state)
        case 3: try decoder.decodeSingularStringField(value: &_storage._name)
        case 4: try decoder.decodeSingularBytesField(value: &_storage._mac)
        case 5: try decoder.decodeSingularMessageField(value: &_storage._ipconfig)
        case 6: try decoder.decodeSingularMessageField(value: &_storage._dnsconfig)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if _storage._interface != 0 {
        try visitor.visitSingularInt32Field(value: _storage._interface, fieldNumber: 1)
      }
      if _storage._state != .networkStatusNone {
        try visitor.visitSingularEnumField(value: _storage._state, fieldNumber: 2)
      }
      if !_storage._name.isEmpty {
        try visitor.visitSingularStringField(value: _storage._name, fieldNumber: 3)
      }
      if !_storage._mac.isEmpty {
        try visitor.visitSingularBytesField(value: _storage._mac, fieldNumber: 4)
      }
      if let v = _storage._ipconfig {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
      }
      if let v = _storage._dnsconfig {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Particle_Ctrl_NetworkConfiguration) -> Bool {
    if _storage !== other._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((_storage, other._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let other_storage = _args.1
        if _storage._interface != other_storage._interface {return false}
        if _storage._state != other_storage._state {return false}
        if _storage._name != other_storage._name {return false}
        if _storage._mac != other_storage._mac {return false}
        if _storage._ipconfig != other_storage._ipconfig {return false}
        if _storage._dnsconfig != other_storage._dnsconfig {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if unknownFields != other.unknownFields {return false}
    return true
  }
}
