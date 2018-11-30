//
//  AddressUtil.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation
import CryptoSwift
import CryptoEthereumSwift
import EthereumKit

public struct AddressUtil {

    public static func generateAddress(privateKey: Data) -> String{
        let pubKey = HashUtil.getPublicKey(privateKey: privateKey)
        let pubHash = HashUtil.getPublicKeyHash(publicKey: pubKey)
        return generateAddressFromPublickeyHash(pubKeyHash: pubHash)
    }
    public static func generateAddressFromPublickeyHash(pubKeyHash: Data) -> String{
        let fullPubHash: Data = Data(pubKeyHash.bytes)
        print(fullPubHash.bytes)
        let checksum = CryptoHash.sha256(CryptoHash.sha256(fullPubHash)).bytes
        print("checksum: \(checksum)")
        print(checksum.prefix(4))
        print((fullPubHash + checksum.prefix(4)).bytes)
        return Base58.encode(fullPubHash + checksum.prefix(4))
    }
}
