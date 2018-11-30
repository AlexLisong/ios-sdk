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
    public static func secp256k1Sign(hash: Data, privateKey: Data) -> Data?{
        let signature = try? CryptoEthereumSwift.Crypto.sign(hash, privateKey:  privateKey)
        return signature
    }
    public static func getPublicKey(privateKey: Data) ->Data{
        return Secp256k1.generatePublicKey(withPrivateKey: privateKey, compression: false).dropFirst()
    }
    public static func getPublicKeyHash(publicKey: Data) -> Data{
        print(publicKey.bytes)
        let sha = publicKey.bytes.sha3(.sha256)
        print(sha.toHexString())
        return Data(bytes: [0x5A] + CryptoHash.ripemd160(Data(bytes: sha)).bytes)
    }
    public static func getPublicKeyHash(address: String) -> Data{
        let fullPubHash = Data(base58Decoding: address)!
        return fullPubHash.dropLast(4)
    }}
