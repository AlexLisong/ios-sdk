//
//  HashTests.swift
//  DappleySwiftTests
//
//  Created by Li Song on 2018-12-03.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import XCTest
import EthereumKit
import CryptoEthereumSwift
import secp256k1
@testable import DappleySwift

class HashTests: XCTestCase {
    func testGetPubKeyHashFromPublicKey(){
        let data = Data([222, 100, 50])
        print("Data: \(Array(data))")
        
        let encoded = String(base58Encoding: data)
        print("Encoded string: \(encoded)")
        
        let decoded = Data(base58Decoding: encoded)!
        print("Decoded data: \(Array(decoded))")
        
        var pubHash = AddressUtil.getPublicKeyHash(address: "dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW")
        
        print(pubHash.toHexString())
        print(pubHash.bytes)
        var pubHashExpected = Data(bytes: [90, 21, 208 ,12 ,55, 114, 238, 144, 115, 134 ,186, 153, 185, 229, 142, 57, 32, 199, 93, 93, 57])
        XCTAssertEqual(pubHash.bytes, pubHashExpected.bytes)
        
        print(pubHash.bytes)
        pubHash = AddressUtil.getPublicKeyHash(address: "dMjVoMPgZonQ6QKUT7efvHzUFNTT8r1qSp")
        print(pubHash.toHexString())
        pubHashExpected = Data(bytes: [90, 91, 50, 169, 181, 210, 191, 66, 118, 60, 29, 19, 221, 112, 254, 44, 203, 19, 123, 100, 40])
        XCTAssertEqual(pubHash.bytes, pubHashExpected.bytes)
    }
    func testGetPubKeyHashContract(){
        let publicKey = Data(hex: "047e63dc23f0f6ecb0b2ab8a649f0e2966e9c6ceb10f901e0e0b712cfed2f78449710b2e3e0ce01386f5b1d4533dc21bb1b6d1dfc989884b0e099e3e25ce210e3d")
        var pubHash = HashUtil.getPublicKeyHash(publicKey: publicKey, isUserAddress: true)
        var pubHashExpected = Data(hex: "5aaafa131efa283381ce7d582bc09d3441501d9620")
        XCTAssertEqual(pubHash, pubHashExpected)

        pubHash = HashUtil.getPublicKeyHash(publicKey: publicKey, isUserAddress: false)
        pubHashExpected = Data(hex: "58aafa131efa283381ce7d582bc09d3441501d9620")
        XCTAssertEqual(pubHash, pubHashExpected)
        
        pubHash = AddressUtil.getPublicKeyHash(address: "dMjVoMPgZonQ6QKUT7efvHzUFNTT8r1qSp")
        pubHashExpected = Data(hex: "5a5b32a9b5d2bf42763c1d13dd70fe2ccb137b6428")
        XCTAssertEqual(pubHash, pubHashExpected)
    }
}
