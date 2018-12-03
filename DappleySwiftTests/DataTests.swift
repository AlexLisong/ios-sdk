//
//  DataTests.swift
//  DappleySwiftTests
//
//  Created by Li Song on 2018-11-28.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import XCTest
import EthereumKit
import CryptoEthereumSwift
import secp256k1
@testable import DappleySwift

class DataTests: XCTestCase {
    func testDataAndBInt() {
        var bint = BInt(17)
        let int = DataUtil.data2BInt(data: Data(bytes: [1, 109, 139, 74, 212, 0]))!
        XCTAssertEqual([0, 0, 0, 1], DataUtil.toByteArray(value: 1))
    }
    
}
