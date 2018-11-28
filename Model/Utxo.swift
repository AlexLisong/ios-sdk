//
//  Utxo.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation
import EthereumKit

public struct Utxo {
    public let amount: BInt
    
    public let publicKeyHash: Data
    
    public let txid: Data
    
    public let txIndex: UInt32
    
    public init(amount: Data, publicKeyHash: Data, txid: Data, txIndex: UInt32) {
        self.amount = DataUtil.Data2BInt(data: amount)!
        self.publicKeyHash = publicKeyHash
        self.txid = txid
        self.txIndex = txIndex
    }
}
