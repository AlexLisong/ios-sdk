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

    public var txid: Data = Data()
    
    public var vout: Int32 = 0
    
    public var signature: Data = Data()
    
    public var pubKey: Data = Data()
    
    internal func toProto() -> Corepb_TXInput{
        var input = Corepb_TXInput()
        input.txid = self.txid
        input.vout = self.vout
        input.signature = self.signature
        input.pubKey = self.pubKey
        return input
    }
    
    public func serialized() -> Data {
        var data = Data()
        data += txid
        data += Data(withUnsafeBytes(of: vout) { Data($0) })
        data += signature
        data += pubKey
        return data
    }
    public init() {
    }
    public init(txid: Data, vout: Int32, pubKey: Data) {
        self.txid = txid
        self.vout = vout
        self.signature = Data(hex: "")
        self.pubKey = pubKey
    }
    public mutating func setSignature(signature: Data){
        self.signature = signature
    }
}

