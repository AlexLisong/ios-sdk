//
//  Parcel.swift
//  DappleySwift
//
//  Created by Li Song on 2018-12-03.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation
import EthereumKit
public struct Parcel {
    
    public static let TIP_DEFAULT: BInt = 1

    public var value: BInt = 0
    
    public var toAddress: String
    
    public var contract: String = String()
    
    public var tip: BInt = 0
    
    public init(toAddress: String, tip: BInt = Parcel.TIP_DEFAULT, value: BInt = 0, contract: String = "") {
        self.toAddress = toAddress
        self.tip = tip
        self.value = value
        self.contract = contract
    }

}
