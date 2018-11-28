//
//  Util.swift
//  DappleySwiftTests
//
//  Created by Li Song on 2018-11-27.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation
import EthereumKit

public struct DataUtil {
    public static func Data2BInt(data: Data) -> BInt?{
        let stringInt = String.init(data: data, encoding: String.Encoding.utf8)
        return BInt.init(stringInt!)
    }
}
