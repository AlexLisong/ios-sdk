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
    /*
     privKey:  f00fbae3a1ecd3de06be15cc455443fcf275008a04c1f69689a2f670f6f49c5b
     pubKey:    1a63ad06daf0bc01a013a0223e6457d4fdbecb4549c7de0b26d13923c0a9e55bc404940aa002d93182fb84b34e6ba22edfc2ac6b720d34b5ea9bb64e75271c92
                1a63ad06daf0bc01a013a0223e6457d4fdbecb4549c7de0b26d13923c0a9e55bc404940aa002d93182fb84b34e6ba22edfc2ac6b720d34b5ea9bb64e75271c92
     pubKey:041a63ad06daf0bc01a013a0223e6457d4fdbecb4549c7de0b26d13923c0a9e55bc404940aa002d93182fb84b34e6ba22edfc2ac6b720d34b5ea9bb64e75271c92
            041a63ad06daf0bc01a013a0223e6457d4fdbecb4549c7de0b26d13923c0a9e55bc404940aa002d93182fb84b34e6ba22edfc2ac6b720d34b5ea9bb64e75271c92
              d7238225aa811f4df6ae313560fc81788b3b8725aef3ec62dea888bc1e93a4c9acfa2783f4696157b582e662d0185cdd28bfe45cb5d7e3b543d20ac735815
     address-user:  dUUJ826xi12tCq4D465xyAFn9kKs7VVsgp
                    dX3Puv6xKKQn7Sre5yg3taq8oMe6md5F6p
                    dVU4CqS7SkvMMboshARnShGMt3L1Pj1mbS
     address-user:  fd7031ead41f045cef507da20715699bcd1a325c
    */
    func testAddressGeneration2() {
        let pk = Data(hex: "f00fbae3a1ecd3de06be15cc455443fcf275008a04c1f69689a2f670f6f49c5b")

        let pubKey = HashUtil.GetPublicKey(privateKey: pk) //Secp256k1.generatePublicKey(withPrivateKey: pk, compression: false).dropFirst()
        //print(pubKey.toHexString())
        let pubHash = HashUtil.getPublicKeyHash(publicKey: pubKey)
        let addr = AddressUtil.CreateAddress(pubKeyHash: pubHash)
        XCTAssertEqual(addr, "dUUJ826xi12tCq4D465xyAFn9kKs7VVsgp")
    }
    func testHashUtilPubkeyHash(){
        //publicKey := []uint8([]byte{0xd7, 0x23, 0x82, 0x25, 0xaa, 0x81, 0x1f, 0x4d, 0xf6, 0xae, 0x31, 0x35, 0x60, 0xfc, 0x81, 0x7, 0x8, 0x8b, 0x3b, 0x87, 0x25, 0xae, 0xf3, 0xec, 0x62, 0xde, 0xa8, 0x88, 0xbc, 0x1e, 0x93, 0xa4, 0xc9, 0xac, 0xfa, 0x27, 0x83, 0xf4, 0x69, 0x61, 0x57, 0xb5, 0x82, 0xe6, 0x62, 0xd0, 0x18, 0x5c, 0xdd, 0x28, 0xbf, 0xe4, 0x5c, 0xb5, 0xd7, 0xe3, 0xb5, 0x43, 0xd, 0x20, 0xac, 0x73, 0x58, 0x15})
        /*2018/11/24 16:43:21 [97 100 100 114 101 115 115 49 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48]
        2018/11/24 16:43:21 [239 116 116 254 125 14 195 123 14 23 31 163 161 97 139 31 249 100 175 48 239 112 230 195 163 23 186 10 103 185 181 49]
        2018/11/24 16:43:21 [190 103 197 98 174 212 29 142 228 195 26 11 165 93 249 16 90 241 24 239]
        2018/11/24 16:43:21 [97 100 100 114 101 115 115 50 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48]
        2018/11/24 16:43:21 [2 198 29 194 193 83 135 225 229 184 99 158 160 244 63 61 72 170 146 138 51 119 50 177 48 15 44 157 93 62 110 125]
        2018/11/24 16:43:21 [172 213 69 228 29 17 110 175 186 89 159 61 146 210 164 30 171 109 109 111]
        === RUN   TestNewUserPubKeyHash
        2018/11/24 16:43:21 [215 35 130 37 170 129 31 77 246 174 49 53 96 252 129 7 8 139 59 135 37 174 243 236 98 222 168 136 188 30 147 164 201 172 250 39 131 244 105 97 87 181 130 230 98 208 24 92 221 40 191 228 92 181 215 227 181 67 13 32 172 115 88 21]
        2018/11/24 16:43:21 [79 155 142 164 96 161 55 120 51 110 195 61 134 37 185 194 212 95 194 248 52 177 187 84 11 72 112 169 54 54 98 132]
        2018/11/24 16:43:21 [133 204 43 201 20 110 39 44 248 244 176 171 165 192 241 79 179 50 39 199]
         
         2018/11/24 16:50:07 [215 35 130 37 170 129 31 77 246 174 49 53 96 252 129 7 8 139 59 135 37 174 243 236 98 222 168 136 188 30 147 164 201 172 250 39 131 244 105 97 87 181 130 230 98 208 24 92 221 40 191 228 92 181 215 227 181 67 13 32 172 115 88 21]
         2018/11/24 16:50:07 [252 229 229 42 31 161 86 57 113 89 249 60 100 97 210 18 236 190 104 178 177 140 163 245 102 180 106 17 81 47 227 199]
         2018/11/24 16:50:07 [177 52 76 23 103 76 24 209 162 220 234 159 23 22 224 73 244 160 94 108]

*/
        /*
         2018/11/24 19:47:50 [215 35 130 37 170 129 31 77 246 174 49 53 96 252 129 7 8 139 59 135 37 174 243 236 98 222 168 136 188 30 147 164 201 172 250 39 131 244 105 97 87 181 130 230 98 208 24 92 221 40 191 228 92 181 215 227 181 67 13 32 172 115 88 21]
         2018/11/24 19:47:50 [252 229 229 42 31 161 86 57 113 89 249 60 100 97 210 18 236 190 104 178 177 140 163 245 102 180 106 17 81 47 227 199]
         2018/11/24 19:47:50 [177 52 76 23 103 76 24 209 162 220 234 159 23 22 224 73 244 160 94 108]
         2018/11/24 19:47:50 [90 177 52 76 23 103 76 24 209 162 220 234 159 23 22 224 73 244 160 94 108]
         2018/11/24 19:47:50 [141 198 30 154]
         2018/11/24 19:47:50 [90 177 52 76 23 103 76 24 209 162 220 234 159 23 22 224 73 244 160 94 108 141 198 30 154]
         2018/11/24 19:47:50 dVaFsQL9He4Xn4CEUh1TCNtfEhHNHKX3hs
         */
        let input : [UInt8] = [0xd7, 0x23, 0x82, 0x25, 0xaa, 0x81, 0x1f, 0x4d, 0xf6, 0xae, 0x31, 0x35, 0x60, 0xfc, 0x81, 0x7, 0x8, 0x8b, 0x3b, 0x87, 0x25, 0xae, 0xf3, 0xec, 0x62, 0xde, 0xa8, 0x88, 0xbc, 0x1e, 0x93, 0xa4, 0xc9, 0xac, 0xfa, 0x27, 0x83, 0xf4, 0x69, 0x61, 0x57, 0xb5, 0x82, 0xe6, 0x62, 0xd0, 0x18, 0x5c, 0xdd, 0x28, 0xbf, 0xe4, 0x5c, 0xb5, 0xd7, 0xe3, 0xb5, 0x43, 0xd, 0x20, 0xac, 0x73, 0x58, 0x15]
        /*
        let sha = input.sha3(.sha256)
        print("sha----\(sha)")
        let hash = CryptoHash.ripemd160(Data(bytes: sha))
        print(hash.bytes)*/
        let pubKey = Data(bytes: input)
        
        let pubHash = HashUtil.getPublicKeyHash(publicKey: pubKey)
        let addr = AddressUtil.CreateAddress(pubKeyHash: pubHash)
        XCTAssertEqual(addr, "dVaFsQL9He4Xn4CEUh1TCNtfEhHNHKX3hs")

        //dVaFsQL9He4Xn4CEUh1TCNtfEhHNHKX3hs
        /*
         expect := []uint8([]byte{versionUser,0xb1, 0x34, 0x4c, 0x17, 0x67, 0x4c, 0x18, 0xd1, 0xa2, 0xdc, 0xea, 0x9f, 0x17, 0x16, 0xe0, 0x49, 0xf4, 0xa0, 0x5e, 0x6c})
        
        publicKey := []uint8([]byte{0xd7, 0x23, 0x82, 0x25, 0xaa, 0x81, 0x1f, 0x4d, 0xf6, 0xae, 0x31, 0x35, 0x60, 0xfc, 0x81, 0x7, 0x8, 0x8b, 0x3b, 0x87, 0x25, 0xae, 0xf3, 0xec, 0x62, 0xde, 0xa8, 0x88, 0xbc, 0x1e, 0x93, 0xa4, 0xc9, 0xac, 0xfa, 0x27, 0x83, 0xf4, 0x69, 0x61, 0x57, 0xb5, 0x82, 0xe6, 0x62, 0xd0, 0x18, 0x5c, 0xdd, 0x28, 0xbf, 0xe4, 0x5c, 0xb5, 0xd7, 0xe3, 0xb5, 0x43, 0xd, 0x20, 0xac, 0x73, 0x58, 0x15})
 */
        //2018/11/24 15:44:41 [215 35 130 37 170 129 31 77 246 174 49 53 96 252 129 7 8 139 59 135 37 174 243 236 98 222 168 136 188 30 147 164 201 172 250 39 131 244 105 97 87 181 130 230 98 208 24 92 221 40 191 228 92 181 215 227 181 67 13 32 172 115 88 21]

    }
}
