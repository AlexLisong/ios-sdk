//
//  AddressTests.swift
//  DappleySwiftTests
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import XCTest
import EthereumKit
import CryptoEthereumSwift
import secp256k1
@testable import DappleySwift

class AddressTests: XCTestCase {
    func testAddressInitialization() {
        let string = "0x88b44BC83add758A3642130619D61682282850Df"
        let hex = "88b44bc83add758a3642130619d61682282850df"
        XCTAssert(Address(data: Data(hex: hex)).string == string)
        XCTAssert(Address(string: string).data.toHexString() == hex)
    }
    
    func testAddressGeneration() {
        let entropy = Data(hex: "000102030405060708090a0b0c0d0e0f")
        let mnemonic = Mnemonic.create(entropy: entropy)
        let seed = try! Mnemonic.createSeed(mnemonic: mnemonic)
        let wallet = HDWallet(seed: seed, network: .mainnet)
        
        let firstAddress = try! wallet.address(at: 0)
        XCTAssertEqual(firstAddress, "0x83f1caAdaBeEC2945b73087F803d404F054Cc2B7")
        
        let secondAddress = try! wallet.address(at: 1)
        XCTAssertEqual(secondAddress, "0xb3c3D923CFc4d551b38Db8A86BbA42B623D063cE")
        
        let thirdAddress = try! wallet.address(at: 2)
        XCTAssertEqual(thirdAddress, "0x82e35B34CfBEB9704E51Eb17f8263d919786E66a")
        
        let forthAddress = try! wallet.address(at: 3)
        XCTAssertEqual(forthAddress, "0xCF1D652DAb65ea4f10990FD2D2E59Cd7cbEb315a")
    }

    func testAddressGeneration2() {
        
        let pk = Data(hex: "f00fbae3a1ecd3de06be15cc455443fcf275008a04c1f69689a2f670f6f49c5b")
        let pubKey = HashUtil.getPublicKey(privateKey: pk) 
        let pubHash = HashUtil.getPublicKeyHash(publicKey: pubKey)
        let addr = AddressUtil.generateAddressFromPublickeyHash(pubKeyHash: pubHash)
        XCTAssertEqual(addr, "dVU4CqS7SkvMMboshARnShGMt3L1Pj1mbS")
    }
    
    //Compare the result to java version
    func testAddressGeneration3() {
        
        let pk = Data(hex: "300c0338c4b0d49edc66113e3584e04c6b907f9ded711d396d522aae6a79be1a")
        let pubKey = HashUtil.getPublicKey(privateKey: pk)
        let pubHash = HashUtil.getPublicKeyHash(publicKey: pubKey)
        var addr = AddressUtil.generateAddressFromPublickeyHash(pubKeyHash: pubHash)
        XCTAssertEqual(addr, "dastXXWLe5pxbRYFhcyUq8T3wb5srWkHKa")
        XCTAssertEqual(pubHash, HashUtil.getPublicKeyHash(address: addr))
        
        addr = AddressUtil.generateAddress(privateKey: Data(hex: "4ecff43e39d3d65bfaa3eca0999fddecf12785228269c772b603dd93532c748f"))
        XCTAssertEqual(addr, "dU5ErX1uP5QYq5ENZUgJGMjDkR4VbS6LDC")
        
        addr = AddressUtil.generateAddress(privateKey: Data(hex: "f00fbae3a1ecd3de06be15cc455443fcf275008a04c1f69689a2f670f6f49c5b"))
        XCTAssertEqual(addr, "dVU4CqS7SkvMMboshARnShGMt3L1Pj1mbS")
        
        addr = AddressUtil.generateAddress(privateKey: Data(hex: "accfeef16d9ac928d93b28c059dee85a256c75af6248c1d2e6a39a14c4957a55"))
        XCTAssertEqual(addr, "dVUXs8hLzi5iSRYabMUq2AiNY8uHjYTmrG")
        /*
         4ecff43e39d3d65bfaa3eca0999fddecf12785228269c772b603dd93532c748f
         userAddress: dU5ErX1uP5QYq5ENZUgJGMjDkR4VbS6LDC
         
         f00fbae3a1ecd3de06be15cc455443fcf275008a04c1f69689a2f670f6f49c5b
         userAddress: dVU4CqS7SkvMMboshARnShGMt3L1Pj1mbS
         
         accfeef16d9ac928d93b28c059dee85a256c75af6248c1d2e6a39a14c4957a55
         userAddress: dVUXs8hLzi5iSRYabMUq2AiNY8uHjYTmrG
         */
    }
    //Compare the result to go version
    /*
     2018/11/25 11:32:18 [215 35 130 37 170 129 31 77 246 174 49 53 96 252 129 7 8 139 59 135 37 174 243 236 98 222 168 136 188 30 147 164 201 172 250 39 131 244 105 97 87 181 130 230 98 208 24 92 221 40 191 228 92 181 215 227 181 67 13 32 172 115 88 21]
     2018/11/25 11:32:18 [252 229 229 42 31 161 86 57 113 89 249 60 100 97 210 18 236 190 104 178 177 140 163 245 102 180 106 17 81 47 227 199]
     2018/11/25 11:32:18 [177 52 76 23 103 76 24 209 162 220 234 159 23 22 224 73 244 160 94 108]
     2018/11/25 11:32:18 [90 177 52 76 23 103 76 24 209 162 220 234 159 23 22 224 73 244 160 94 108]
     2018/11/25 11:32:18 [141 198 30 154]
     2018/11/25 11:32:18 [90 177 52 76 23 103 76 24 209 162 220 234 159 23 22 224 73 244 160 94 108 141 198 30 154]
     2018/11/25 11:32:18 dVaFsQL9He4Xn4CEUh1TCNtfEhHNHKX3hs*/
    func testHashUtilPubkeyHash(){
        let input : [UInt8] = [0xd7, 0x23, 0x82, 0x25, 0xaa, 0x81, 0x1f, 0x4d, 0xf6, 0xae, 0x31, 0x35, 0x60, 0xfc, 0x81, 0x7, 0x8, 0x8b, 0x3b, 0x87, 0x25, 0xae, 0xf3, 0xec, 0x62, 0xde, 0xa8, 0x88, 0xbc, 0x1e, 0x93, 0xa4, 0xc9, 0xac, 0xfa, 0x27, 0x83, 0xf4, 0x69, 0x61, 0x57, 0xb5, 0x82, 0xe6, 0x62, 0xd0, 0x18, 0x5c, 0xdd, 0x28, 0xbf, 0xe4, 0x5c, 0xb5, 0xd7, 0xe3, 0xb5, 0x43, 0xd, 0x20, 0xac, 0x73, 0x58, 0x15]
        let pubKey = Data(bytes: input)
        let pubHash = HashUtil.getPublicKeyHash(publicKey: pubKey)
        let addr = AddressUtil.generateAddressFromPublickeyHash(pubKeyHash: pubHash)
        XCTAssertEqual(addr, "dVaFsQL9He4Xn4CEUh1TCNtfEhHNHKX3hs")
        XCTAssertEqual(pubHash, HashUtil.getPublicKeyHash(address: addr))
   }
    
    //Compare the result to go version
    /*
     2018/11/25 11:07:04 [96 240 241 207 204 188 26 9 31 69 160 39 49 48 155 141 198 28 235 182 50 10 153 121 144 187 100 217 149 151 195 243 158 221 32 9 57 80 173 43 78 127 30 171 114 193 226 110 167 54 232 91 248 198 35 124 253 129 56 124 35 5 99 38]
     2018/11/25 11:07:04 [31 101 113 205 117 188 194 192 98 42 93 181 241 140 92 28 2 244 92 113 127 138 97 220 188 117 33 99 25 111 17 138]
     2018/11/25 11:07:04 [160 191 66 213 41 48 240 90 93 161 59 88 4 124 15 87 5 14 220 117]
     2018/11/25 11:07:04 [90 160 191 66 213 41 48 240 90 93 161 59 88 4 124 15 87 5 14 220 117]
     2018/11/25 11:07:04 [234 152 73 135]
     2018/11/25 11:07:04 [90 160 191 66 213 41 48 240 90 93 161 59 88 4 124 15 87 5 14 220 117 234 152 73 135]
     2018/11/25 11:07:04 dU5ErX1uP5QYq5ENZUgJGMjDkR4VbS6LDC*/
    func testHashUtilPubkeyHash2(){
        let input : [UInt8] = [96,240,241,207,204,188,26,9,31,69,160,39,49,48,155,141,198,28,235,182,50,10,153,121,144,187,100,217,149,151,195,243,158,221,32,9,57,80,173,43,78,127,30,171,114,193,226,110,167,54,232,91,248,198,35,124,253,129,56,124,35,5,99,38]
        let pubKey = Data(bytes: input)
        let pubHash = HashUtil.getPublicKeyHash(publicKey: pubKey)
        let addr = AddressUtil.generateAddressFromPublickeyHash(pubKeyHash: pubHash)
        XCTAssertEqual(addr, "dU5ErX1uP5QYq5ENZUgJGMjDkR4VbS6LDC")
        XCTAssertEqual(pubHash, HashUtil.getPublicKeyHash(address: addr))

    }
}
