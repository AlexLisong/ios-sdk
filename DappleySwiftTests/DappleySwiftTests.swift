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
    private var rpc:RpcProvider = RpcProvider (host: "18.224.247.158:50050")
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let rpc = RpcProvider (host: "18.224.247.158:50050")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGPRC() {
        gRPC.initialize()
        print(rpc.getBlockchainInfo())
        print(rpc.getBlockByHeight())
        rpc.getUtxos(address: "dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW")
        print("the number of blocks: \(rpc.getBlocks())")
        print("get balance: \(rpc.getBalance(address: "dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW"))")
        gRPC.shutdown()
        
    }
    func testGRPCSend(){
        var amount:BInt = 3
        var parcel = Parcel(toAddress: "dMjVoMPgZonQ6QKUT7efvHzUFNTT8r1qSp", tip: 2, value: amount, contract: "")
        rpc.send(from: "dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW", parcel: parcel, privateKey: Data(hex: "0f5645a3a724a0e079df5f3b477da82b280d64c750a2d499291fc66b3f1deb15"))
    }
    func testGRPCSendContract(){
        var amount:BInt = 3
        var parcel = Parcel(toAddress: "cMjVoMPgZonQ6QKUT7efvHzUFNTT8r1qSp", tip: 2, value: amount, contract: "hello world")
        rpc.send(from: "dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW", parcel: parcel, privateKey: Data(hex: "0f5645a3a724a0e079df5f3b477da82b280d64c750a2d499291fc66b3f1deb15"))
    }
    func testGRPCUpdateSteps(){
        var amount:BInt = 3
        var parcel = Parcel(toAddress: "cctaYJtTPL1qDiQJUz967jLh6buhjV6UpB", tip: 1, value: amount, contract: "{\"function\":\"record\",\"args\":[\"dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW\",\"12\"]}")
        rpc.send(from: "dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW", parcel: parcel, privateKey: Data(hex: "0f5645a3a724a0e079df5f3b477da82b280d64c750a2d499291fc66b3f1deb15"))
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}


