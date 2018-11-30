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
        data += txid.bytes
        print("txinput")
        print(txid.bytes)
        data += Data(bytes: DataUtil.toByteArray(value: vout))
        print(vout)
        print(DataUtil.toByteArray(value: vout))
        print(data.bytes)
        data += pubKey.bytes
        print("pub: \(pubKey.bytes)")
        print(data.bytes)
        data += signature.bytes
        print(signature.bytes)
        print("txinput -- end")

        return data
    }
    /*
     for _, vin := range tx.Vin {
     bytes = append(bytes, vin.Txid...)
     // int size may differ from differnt platform
     bytes = append(bytes, byteutils.FromInt32(int32(vin.Vout))...)
     bytes = append(bytes, vin.PubKey...)
     bytes = append(bytes, vin.Signature...)
     }
     
     for _, vout := range tx.Vout {
     bytes = append(bytes, vout.Value.Bytes()...)
     bytes = append(bytes, vout.PubKeyHash.GetPubKeyHash()...)
     }
     
     bytes = append(bytes, byteutils.FromUint64(tx.Tip)...)
     
     */
    
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

