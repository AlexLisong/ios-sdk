//
//  TransactionTests.swift
//  DappleySwiftTests
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import XCTest
import SwiftGRPC
import SwiftProtobuf
import CryptoSwift
import CryptoEthereumSwift
@testable import DappleySwift

class TransactionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testSign(){
        let pk = Data(hex: "300c0338c4b0d49edc66113e3584e04c6b907f9ded711d396d522aae6a79be1a")
        let msg = CryptoHash.sha256("hello world".data(using: .ascii)!)
        print("msg: \(msg.toHexString())")
        let util = HashUtil()
        
        XCTAssertEqual(util.Secp256k1Sign(hash: msg, privateKey: pk)!.toHexString(), "cd7c36f9cf69feb13f75859382fcdc2ac6c97d9c13dbbe42dc4ceb7eb29f454b101528db47edb53ce7cffc99f251e47ecfa689fc6730de7aae7ba540e64d672f01")
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
