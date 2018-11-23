//
//  Transaction.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation
public struct Transaction {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
    public let id: Data
    
    public let vin: [TXInput] = []
    
    public let vout: [TXOutput] = []
    
    public var tip: UInt64 = 0
    
    public init(id: Data, tip: UInt64) {
        self.id = id
        self.tip = tip
    }
    
}
