//
//  MnemonicManagerTests.swift
//  DappleySwiftTests
//
//  Created by Li Song on 2019-01-19.
//  Copyright © 2019 Alex Song. All rights reserved.
//

import Foundation
import XCTest
import CryptoSwift
import CryptoEthereumSwift
@testable import DappleySwift

final class MnemonicManagerTests: XCTestCase {

    func testMnemonicWords1() {
        
        let mnemonic = "abandon amount liar amount expire adjust cage candy arch gather drum buyer"
            .split(separator: " ")
            .map(String.init)
        
        let seed = try! MnemonicManager.createSeed(mnemonic: mnemonic)
        XCTAssertEqual(
            seed.toHexString(),
            "3779b041fab425e9c0fd55846b2a03e9a388fb12784067bd8ebdb464c2574a05bcc7a8eb54d7b2a2c8420ff60f630722ea5132d28605dbc996c8ca7d7a8311c0"
        )
        
        let mnc = try! MnemonicManager.create(entropy: Data(hex: "3779b041fab425e9c0fd55846b2a03e9a388fb12784067bd8ebdb464c2574a05bcc7a8eb54d7b2a2c8420ff60f630722ea5132d28605dbc996c8ca7d7a8311c0"))
    }
    func testMnemonicWords2() {
        
        let mnemonic = "fox danger popular slender tobacco portion hour use neither then canal income"
            .split(separator: " ")
            .map(String.init)
        
        let pk = KeyUtil.getPrivateKeyFromMnemonic(mnemonic: mnemonic)
        XCTAssertEqual(
            pk.toHexString(),
            "bb29db21e32ffcb942071ca41ab313d524d67e6b61f6353e7991f5c33a8a8ff7"
        )
        let mnc = try! MnemonicManager.create(language: .chinese)
        print(mnc)
    }
    func testMnemonicWords3() {
        
        let mnemonic = "edit shop copy ecology grain knife anchor reopen floor detail essay buffalo"
            .split(separator: " ")
            .map(String.init)
        
        let pk = KeyUtil.getPrivateKeyFromMnemonic(mnemonic: mnemonic)

        XCTAssertEqual(
            pk.toHexString(),
            "d24cc925bfa4089f5adb8996a227c844fab4357507e3cdaf2f95295a7ac04992"
        )
    }
    func testMnemonicWords4() {
        
        let mnemonic = "view brave hazard solution believe oxygen click few abuse mail pretty west"
            .split(separator: " ")
            .map(String.init)
        
        let pk = KeyUtil.getPrivateKeyFromMnemonic(mnemonic: mnemonic)

        XCTAssertEqual(
            pk.toHexString(),
            "40fc893f2488a55624883a82ac6d8c399c8a99c222005b879881f0a3e1406ac6"
        )
    }
    func testMnemonicWords5() {
        
        let mnemonic = "maze action together neither reduce apple over this square glide write symptom"
            .split(separator: " ")
            .map(String.init)
        
        let pk = KeyUtil.getPrivateKeyFromMnemonic(mnemonic: mnemonic)

        XCTAssertEqual(
            pk.toHexString(),
            "fe8f91a1b4ef0b22e867d1930459d98201955c333b6c2c470e110d06980d3c3d"
        )
    }
    
    
    func testMnemonicWordsWhenInvalid() {
        let mnemonic = "bug amount liar amount expire adjust cage candy arch gather drum buyer"
            .split(separator: " ")
            .map(String.init)
        
        XCTAssertThrowsError(try MnemonicManager.createSeed(mnemonic: mnemonic))
    }

}
