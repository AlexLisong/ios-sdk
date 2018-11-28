//
//  TxOutput.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation
import EthereumKit
public struct TXOutput {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
    public var value: BInt = 0
    
    public var pubKeyHash: Data = Data()
    
    public var contract: String = String()
    public init() {
    }
    public init(value: BInt, pubKeyHash: Data, contract: String) {
        self.value = value
        self.pubKeyHash = pubKeyHash
        self.contract = contract
    }
    public func serialized() -> Data {
        var data = Data()
        data += Data(withUnsafeBytes(of: value) { Data($0) })
        data += pubKeyHash
        data += Data(hex: contract.toHexString())
        return data
    }
    
}
