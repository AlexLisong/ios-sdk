//
//  TxOutput.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation
public struct TXOutput {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
    public let value: Data
    
    public let pubKeyHash: Data
    
    public var contract: String = String()
    
    public init(value: Data, pubKeyHash: Data, contract: String) {
        self.value = value
        self.pubKeyHash = pubKeyHash
        self.contract = contract
    }
    
}
