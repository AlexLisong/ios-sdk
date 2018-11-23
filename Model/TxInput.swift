//
//  TxInput.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation

public struct TXInput {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
    public let txid: Data
    
    public let vout: Int32 = 0
    
    private let signature: Data
    
    public let pubKey: Data
    
    public init(txid: Data,signature: Data,pubKey: Data) {
        self.txid = txid
        self.signature = signature
        self.pubKey = pubKey
    }
    
}

