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
        let bint = BInt(2)
        let data = DataUtil.BInt2Data(bint: bint)
        let int = DataUtil.Data2BInt(data: data!)!
        print(int)
    }
}
