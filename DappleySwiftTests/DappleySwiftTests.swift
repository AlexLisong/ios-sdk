//
//  DappleySwiftTests.swift
//  DappleySwiftTests
//
//  Created by Li Song on 2018-11-02.
//  Copyright © 2018 Li Song. All rights reserved.
//

import XCTest
import SwiftGRPC
import SwiftProtobuf
import CryptoSwift
import CryptoEthereumSwift
import EthereumKit
@testable import DappleySwift

class DappleySwiftTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGPRC() {
        gRPC.initialize()
        let rpc = RpcProvider (host: "127.0.0.1:50050")
        print(rpc.getBlockchainInfo())
        print(rpc.getBlockByHeight())
        rpc.getUtxos(address: "dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW")
        print("the number of blocks: \(rpc.getBlocks())")
        print("get balance: \(rpc.getBalance(address: "dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW"))")
        gRPC.shutdown()
        
    }
    func testGRPCSend(){
        let rpc = RpcProvider (host: "127.0.0.1:50050")
        var amount:BInt = 3
        rpc.send(from: "dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW", to: "dMjVoMPgZonQ6QKUT7efvHzUFNTT8r1qSp", amount: amount, privateKey: Data(hex: "0f5645a3a724a0e079df5f3b477da82b280d64c750a2d499291fc66b3f1deb15"))
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}


