// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: common.proto
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

/// The field numbers here are just protobuf details.  The value to pay attention to 
/// is the "int_value" option, which corresponds to the numeric value that will 
/// be set in reply frames (which itself ultimately comes from the numeric values
/// in the system_error_t enum in the firmware code).
enum Particle_Ctrl_ResultCode: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case ok // = 0
  case notAllowed // = 1
  case timeout // = 2
  case notFound // = 3
  case alreadyExist // = 4
  case invalidState // = 5
  case noMemory // = 6
  case invalidParam // = 7
  case UNRECOGNIZED(Int)

  init() {
    self = .ok
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .ok
    case 1: self = .notAllowed
    case 2: self = .timeout
    case 3: self = .notFound
    case 4: self = .alreadyExist
    case 5: self = .invalidState
    case 6: self = .noMemory
    case 7: self = .invalidParam
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .ok: return 0
    case .notAllowed: return 1
    case .timeout: return 2
    case .notFound: return 3
    case .alreadyExist: return 4
    case .invalidState: return 5
    case .noMemory: return 6
    case .invalidParam: return 7
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Particle_Ctrl_ResultCode: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Particle_Ctrl_ResultCode] = [
    .ok,
    .notAllowed,
    .timeout,
    .notFound,
    .alreadyExist,
    .invalidState,
    .noMemory,
    .invalidParam,
  ]
}

#endif  // swift(>=4.2)

struct Particle_Ctrl_IPAddress {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var `protocol`: Particle_Ctrl_IPAddress.ProtocolEnum = .none

  var address: Data = SwiftProtobuf.Internal.emptyData

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum ProtocolEnum: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case none // = 0
    case ipv4 // = 1
    case ipv6 // = 2
    case UNRECOGNIZED(Int)

    init() {
      self = .none
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .none
      case 1: self = .ipv4
      case 2: self = .ipv6
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    var rawValue: Int {
      switch self {
      case .none: return 0
      case .ipv4: return 1
      case .ipv6: return 2
      case .UNRECOGNIZED(let i): return i
      }
    }

  }

  init() {}
}

#if swift(>=4.2)

extension Particle_Ctrl_IPAddress.ProtocolEnum: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Particle_Ctrl_IPAddress.ProtocolEnum] = [
    .none,
    .ipv4,
    .ipv6,
  ]
}

#endif  // swift(>=4.2)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "particle.ctrl"

extension Particle_Ctrl_ResultCode: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "OK"),
    1: .same(proto: "NOT_ALLOWED"),
    2: .same(proto: "TIMEOUT"),
    3: .same(proto: "NOT_FOUND"),
    4: .same(proto: "ALREADY_EXIST"),
    5: .same(proto: "INVALID_STATE"),
    6: .same(proto: "NO_MEMORY"),
    7: .same(proto: "INVALID_PARAM"),
  ]
}

extension Particle_Ctrl_IPAddress: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".IPAddress"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "protocol"),
    2: .same(proto: "address"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularEnumField(value: &self.`protocol`)
      case 2: try decoder.decodeSingularBytesField(value: &self.address)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.`protocol` != .none {
      try visitor.visitSingularEnumField(value: self.`protocol`, fieldNumber: 1)
    }
    if !self.address.isEmpty {
      try visitor.visitSingularBytesField(value: self.address, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Particle_Ctrl_IPAddress, rhs: Particle_Ctrl_IPAddress) -> Bool {
    if lhs.`protocol` != rhs.`protocol` {return false}
    if lhs.address != rhs.address {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Particle_Ctrl_IPAddress.ProtocolEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "NONE"),
    1: .same(proto: "IPv4"),
    2: .same(proto: "IPv6"),
  ]
}
