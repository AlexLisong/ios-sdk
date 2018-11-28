//
//  TxInput.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation
import EthereumKit
public struct TXInput {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
    public var txid: Data = Data()
    
    public var vout: UInt32 = 0
    
    public var signature: Data = Data()
    
    public var pubKey: Data = Data()
    
    public func serialized() -> Data {
        var data = Data()
        data += txid
        data += vout
        data += signature
        data += pubKey
        return data
    }
    public init() {
    }
    public init(txid: Data, vout: UInt32, pubKey: Data) {
        self.txid = txid
        self.vout = vout
        self.signature = Data(hex: "")
        self.pubKey = pubKey
    }
    public mutating func setSignature(signature: Data){
        self.signature = signature
    }
}

