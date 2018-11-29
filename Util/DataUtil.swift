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
        let bint = BInt(data.toInt32())
        print(bint)
        return bint
    }
    public static func BInt2Data(bint: BInt) -> Data?{
        return Data(bint.description.utf8)
    }}


private extension Data {
    func toInt32() -> Int32 {
        guard !self.isEmpty else {
            return 0
        }
        var data = self
        var bytes: [UInt8] = []
        var last = data.removeLast()
        let isNegative: Bool = last >= 0x80
        
        while !data.isEmpty {
            bytes.append(data.removeFirst())
        }
        
        if isNegative {
            last -= 0x80
        }
        bytes.append(last)
        
        let value: Int32 = Data(bytes).to(type: Int32.self)
        return isNegative ? -value: value
    }
}

extension Data {
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.pointee }
    }
    
    func to(type: String.Type) -> String {
        return String(bytes: self, encoding: .ascii)!.replacingOccurrences(of: "\0", with: "")
    }
    
}

//extension Data {
//    public init?(hex: String) {
//        let len = hex.count / 2
//        var data = Data(capacity: len)
//        for i in 0..<len {
//            let j = hex.index(hex.startIndex, offsetBy: i * 2)
//            let k = hex.index(j, offsetBy: 2)
//            let bytes = hex[j..<k]
//            if var num = UInt8(bytes, radix: 16) {
//                data.append(&num, count: 1)
//            } else {
//                return nil
//            }
//        }
//        self = data
//    }
//    
//    public var hex: String {
//        return reduce("") { $0 + String(format: "%02x", $1) }
//    }
//}
