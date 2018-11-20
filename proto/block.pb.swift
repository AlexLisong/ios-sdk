// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: block.proto
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

struct Corepb_Block {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var header: Corepb_BlockHeader {
    get {return _storage._header ?? Corepb_BlockHeader()}
    set {_uniqueStorage()._header = newValue}
  }
  /// Returns true if `header` has been explicitly set.
  var hasHeader: Bool {return _storage._header != nil}
  /// Clears the value of `header`. Subsequent reads from it will return its default value.
  mutating func clearHeader() {_storage._header = nil}

  var transactions: [Corepb_Transaction] {
    get {return _storage._transactions}
    set {_uniqueStorage()._transactions = newValue}
  }

  var parentHash: Data {
    get {return _storage._parentHash}
    set {_uniqueStorage()._parentHash = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Corepb_BlockHeader {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var hash: Data = SwiftProtobuf.Internal.emptyData

  var prevhash: Data = SwiftProtobuf.Internal.emptyData

  var nonce: Int64 = 0

  var timestamp: Int64 = 0

  var sign: Data = SwiftProtobuf.Internal.emptyData

  var height: UInt64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "corepb"

extension Corepb_Block: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Block"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "Header"),
    2: .same(proto: "Transactions"),
    3: .same(proto: "parentHash"),
  ]

  fileprivate class _StorageClass {
    var _header: Corepb_BlockHeader? = nil
    var _transactions: [Corepb_Transaction] = []
    var _parentHash: Data = SwiftProtobuf.Internal.emptyData

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _header = source._header
      _transactions = source._transactions
      _parentHash = source._parentHash
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
        case 1: try decoder.decodeSingularMessageField(value: &_storage._header)
        case 2: try decoder.decodeRepeatedMessageField(value: &_storage._transactions)
        case 3: try decoder.decodeSingularBytesField(value: &_storage._parentHash)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._header {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if !_storage._transactions.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._transactions, fieldNumber: 2)
      }
      if !_storage._parentHash.isEmpty {
        try visitor.visitSingularBytesField(value: _storage._parentHash, fieldNumber: 3)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Corepb_Block) -> Bool {
    if _storage !== other._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((_storage, other._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let other_storage = _args.1
        if _storage._header != other_storage._header {return false}
        if _storage._transactions != other_storage._transactions {return false}
        if _storage._parentHash != other_storage._parentHash {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Corepb_BlockHeader: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".BlockHeader"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "Hash"),
    2: .same(proto: "Prevhash"),
    3: .same(proto: "Nonce"),
    4: .same(proto: "Timestamp"),
    5: .same(proto: "Sign"),
    6: .same(proto: "Height"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.hash)
      case 2: try decoder.decodeSingularBytesField(value: &self.prevhash)
      case 3: try decoder.decodeSingularInt64Field(value: &self.nonce)
      case 4: try decoder.decodeSingularInt64Field(value: &self.timestamp)
      case 5: try decoder.decodeSingularBytesField(value: &self.sign)
      case 6: try decoder.decodeSingularUInt64Field(value: &self.height)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.hash.isEmpty {
      try visitor.visitSingularBytesField(value: self.hash, fieldNumber: 1)
    }
    if !self.prevhash.isEmpty {
      try visitor.visitSingularBytesField(value: self.prevhash, fieldNumber: 2)
    }
    if self.nonce != 0 {
      try visitor.visitSingularInt64Field(value: self.nonce, fieldNumber: 3)
    }
    if self.timestamp != 0 {
      try visitor.visitSingularInt64Field(value: self.timestamp, fieldNumber: 4)
    }
    if !self.sign.isEmpty {
      try visitor.visitSingularBytesField(value: self.sign, fieldNumber: 5)
    }
    if self.height != 0 {
      try visitor.visitSingularUInt64Field(value: self.height, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Corepb_BlockHeader) -> Bool {
    if self.hash != other.hash {return false}
    if self.prevhash != other.prevhash {return false}
    if self.nonce != other.nonce {return false}
    if self.timestamp != other.timestamp {return false}
    if self.sign != other.sign {return false}
    if self.height != other.height {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}