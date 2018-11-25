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
extension StringProtocol {
    var hexa2Bytes: [UInt8] {
        let hexa = Array(self)
        return stride(from: 0, to: count, by: 2).compactMap { UInt8(String(hexa[$0..<$0.advanced(by: 2)]), radix: 16) }
    }
}

public struct HashUtil {
    public static func Secp256k1Sign(hash: Data, privateKey: Data) -> Data?{
        let signature = try? Crypto.sign(hash, privateKey:  privateKey)
        return signature
    }
    public static func GetPublicKey(privateKey: Data) ->Data{
        return Secp256k1.generatePublicKey(withPrivateKey: privateKey, compression: false).dropFirst()
    }
    public static func getPublicKeyHash(publicKey: Data) -> Data{
        let sha = publicKey.bytes.sha3(.sha256)
        return CryptoHash.ripemd160(Data(bytes: sha))

        /*
        var theData : [UInt8] = publicKey.toHexString().hexa2Bytes
        print(theData)
        let data = Data(bytes: theData)
        print("datahex\(data.toHexString())")
        let sha = theData.sha3(.sha256)
//Crypto.hashSHA3_256(data)
        print("sha\(sha.toHexString().hexa2Bytes)")
       return CryptoHash.ripemd160(Data(bytes: sha))*/
    }
}
