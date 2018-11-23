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
@testable import DappleySwift

class DappleySwiftTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testSign(){
        let pk = Data(hex: "300c0338c4b0d49edc66113e3584e04c6b907f9ded711d396d522aae6a79be1a")
        let msg = CryptoHash.sha256("hello world".data(using: .ascii)!)
        print("msg: \(msg.toHexString())")
        let util = HashUtil()
        
        XCTAssertEqual(util.Secp256k1Sign(hash: msg, privateKey: pk)!.toHexString(), "cd7c36f9cf69feb13f75859382fcdc2ac6c97d9c13dbbe42dc4ceb7eb29f454b101528db47edb53ce7cffc99f251e47ecfa689fc6730de7aae7ba540e64d672f01")
    }
    func testExample() {
        gRPC.initialize()
        //print("GRPC version", gRPC.version)
        let rpc = RpcProvider (host: "127.0.0.1:50051")
       // gRPC.shutdown()
        print(rpc.GetBlockchainInfo())
        print(rpc.GetBlockByHeight())
        var myInt = 1
        var amount = Data(bytes: &myInt,
                             count: MemoryLayout.size(ofValue: myInt))
        rpc.Send(from: "dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW", to: "dMjVoMPgZonQ6QKUT7efvHzUFNTT8r1qSp", amount: amount)
        //Lis-MacBook-Pro:cli lisong$ ./cli send -from dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW -to dMjVoMPgZonQ6QKUT7efvHzUFNTT8r1qSp -amount 1
        
        print("the number of blocks: \(rpc.GetBlocks())")

        print("get balance: \(rpc.GetBalance(address: "dFQd3DCkKJ226LBVDCFanHM7c891AGxbZW"))")
        
        gRPC.shutdown()
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}


