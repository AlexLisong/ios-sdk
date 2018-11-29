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
        output.value = Data(withUnsafeBytes(of: self.value) { Data($0) })
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
        data += Data(withUnsafeBytes(of: self.value) { Data($0) })
        data += self.pubKeyHash
        data += Data(hex: self.contract.toHexString())
        return data
    }
    
}
