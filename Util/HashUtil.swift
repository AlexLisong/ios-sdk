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
import secp256k1
import EthereumKit
import Base58String

extension StringProtocol {
    var hexa2Bytes: [UInt8] {
        let hexa = Array(self)
        return stride(from: 0, to: count, by: 2).compactMap { UInt8(String(hexa[$0..<$0.advanced(by: 2)]), radix: 16) }
    }
}

public struct HashUtil {
    static let versionUser:[UInt8] = [0x5A]
    static let versionContract:[UInt8] = [0x58]

    public static func secp256k1Sign(hash: Data, privateKey: Data) -> Data?{
        let signature = try? CryptoEthereumSwift.Crypto.sign(hash, privateKey:  privateKey)
        return signature
    }
    public static func getPublicKey(privateKey: Data) ->Data{
        return Secp256k1.generatePublicKey(withPrivateKey: privateKey, compression: false).dropFirst()
    }
    public static func getPublicKeyHash(publicKey: Data, isUserAddress: Bool=true) -> Data{
        let sha = publicKey.bytes.sha3(.sha256)
        return Data(bytes: (isUserAddress ? versionUser : versionContract) + CryptoHash.ripemd160(Data(bytes: sha)).bytes)
    }

}
