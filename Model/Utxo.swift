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
    
    public let txIndex: Int32
    
    public init(amount: Data, publicKeyHash: Data, txid: Data, txIndex: Int32) {
        self.amount = DataUtil.Data2BInt(data: amount)!
        self.publicKeyHash = publicKeyHash
        self.txid = txid
        self.txIndex = txIndex
    }
    
    public static func getPrevUtxos(utxos: [Utxo]) -> Dictionary<String, Utxo>{
        var utxoMap = Dictionary<String,Utxo>()
        for u in utxos {
            utxoMap[u.txid.toHexString() + "-" + String(u.txIndex)] = u
        }
        return utxoMap;
    }
}
