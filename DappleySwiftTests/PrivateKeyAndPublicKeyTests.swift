//
//  PrivateKeyAndPublicKeyTests.swift
//  DappleySwiftTests
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import XCTest
import EthereumKit
@testable import DappleySwift

class PrivateKeyAndPublicKeyTests: XCTestCase {
    
    func testGenerateNewPrivateKey() {
        let pk = KeyUtil.GenerateNewPrivateKey()
        XCTAssertEqual(pk.toHexString().lengthOfBytes(using: String.Encoding.ascii),64)
    }
    func testPrivateKeyAndPublicKey() {
        let privateKey = PrivateKey(raw: Data(hex: "0ac03c260512582a94295185cfa899e0cb8067a89a61b7b5435ec524c088203c"))
        let publicKey = PublicKey(raw: Data(hex: "047e63dc23f0f6ecb0b2ab8a649f0e2966e9c6ceb10f901e0e0b712cfed2f78449710b2e3e0ce01386f5b1d4533dc21bb1b6d1dfc989884b0e099e3e25ce210e3d"))
        XCTAssertEqual(privateKey.publicKey.raw, publicKey.raw)
        XCTAssertEqual(privateKey.publicKey.address(), publicKey.address())
    }
    
    func testPrivateKeyAndPublicKey2() {
        let privateKey = PrivateKey(raw: Data(hex: "56fa1542efa79a278bf78ba1cf11ef20d961d511d344dc1d4d527bc06eeca667"))
        let publicKey = PublicKey(raw: Data(hex: "040f57160f9f618085d3ff835d3a4b9835a586a662c8fb5fd1bb827f92b9cfd140c3f359f1e85253075ca0403bff729121ed1602bb44e65bef4901aced910f4e55"))
        XCTAssertEqual(privateKey.publicKey.raw, publicKey.raw)
        XCTAssertEqual(privateKey.publicKey.address(), publicKey.address())
    }
    
    func testPrivateKeyAndPublicKey3() {
        let privateKey = PrivateKey(raw: Data(hex: "db5cbb5ff9d491f8135c4d0288955c82a2414c6130e143768cab3ddac9fb2fc0"))
        let publicKey = PublicKey(raw: Data(hex: "04a0aedc2e00f2b62cfe6b2d4d68e76f25f03099061cc5e0da0da5daac245e2eb7b75f218cb34c55895a2edb2fa2f196f59a2b8470269892fd7c5a30931f51377d"))
        XCTAssertEqual(privateKey.publicKey.raw, publicKey.raw)
        XCTAssertEqual(privateKey.publicKey.address(), publicKey.address())
    }
    
    func testPrivateKeyAndPublicKey4() {
        let privateKey = PrivateKey(raw: Data(hex: "50f7ca18377d3d7e8a660633af0c94ae509c3da145197f813e58b9b716ca6429"))
        let publicKey = PublicKey(raw: Data(hex: "04d1b4895359166fde9c5b4b661058ec37517a41f4bfd8f2bec4414e4b3a328b8db05101b2baea41d4e229273ec840e3380347cb86524cdd7f5b0ca646e048e6ed"))
        XCTAssertEqual(privateKey.publicKey.raw, publicKey.raw)
        XCTAssertEqual(privateKey.publicKey.address(), publicKey.address())
    }
    
    func testPrivateKeyAndPublicKey5() {
        let privateKey = PrivateKey(raw: Data(hex: "5e52f62afeb325a30db4e3bf076a907e88db78a99ed7ea0d8ac5db5f12ff835a"))
        let publicKey = PublicKey(raw: Data(hex: "04a13182c3bf1832648419e40e356c63c3ecf541a8888e65c8e8dd7f9577e665658c3f994cadcf1aba3057f06dc41d3a89880c0c1d7e6a34636f4e00957478d238"))
        XCTAssertEqual(privateKey.publicKey.raw, publicKey.raw)
        XCTAssertEqual(privateKey.publicKey.address(), publicKey.address())
    }
    
}
