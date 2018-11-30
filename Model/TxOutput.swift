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

    public var value: BInt = 0
    
    public var pubKeyHash: Data = Data()
    
    public var contract: String = String()
    public init() {
    }
    internal func toProto() -> Corepb_TXOutput{
        var output = Corepb_TXOutput()
        print("self.value: \(self.value)")
        output.value = DataUtil.BInt2Data(bint: self.value)!
        print("output.value: \(output.value.bytes)")

        output.pubKeyHash = self.pubKeyHash
        output.contract = self.contract
        return output
    }
    public init(value: BInt, pubKeyHash: Data, contract: String) {
        self.value = value
        self.pubKeyHash = pubKeyHash
        self.contract = contract
    }
    public func serialized() -> Data {
        var data = Data()
        data += DataUtil.BInt2Data(bint: self.value)!
        data += self.pubKeyHash.bytes
        //data += Data(hex: self.contract.toHexString())
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
}
