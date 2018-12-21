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
        output.value = DataUtil.bint2Data(bint: self.value)!

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
        data += DataUtil.bint2Data(bint: self.value)!
        data += self.pubKeyHash.bytes
        data += self.contract.bytes
        return data
    }
}
