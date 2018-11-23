//
//  HashUtil.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-22.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation
import CryptoSwift
import CryptoEthereumSwift

public struct HashUtil {
    public func Secp256k1Sign(hash: Data, privateKey: Data) -> Data?{
        let signature = try? CryptoEthereumSwift.Crypto.sign(hash, privateKey:  privateKey)
        return signature
    }
}
