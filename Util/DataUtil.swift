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
    public static func data2BInt(data: Data) -> BInt?{
        //BInt(<#T##nStr: String##String#>, radix: data)
        print("datahex: \(data.toHexString())")
        let bint = fromHexStringToBInt(nStr: data.toHexString(),radix: 16)! //try! RLP.encode(BInt(nStr: data.toHexString(), radix: 16)!)
        print("bint: \(bint)")
        return bint
    }
    public static func bint2Data(bint: BInt) -> Data?{
        
        var byteArray = try! (RLP.encode(bint).bytes)
        if (byteArray.count > 1){
            byteArray.removeFirst()
        }
        return Data(bytes: byteArray)
    }
    public static func toByteArray(value: Int32) -> [UInt8] {
        if(value == 0){
            return [0,0,0,0]
        }
        var arr = (bint2Data(bint: BInt(value))?.bytes)!
        while (arr.count < 4){
            arr = [0] + arr
        }
        return arr
    }
    public static func uInt64toByteArray(value: UInt64) -> [UInt8] {
        if(value == 0){
            return [0,0,0,0,0,0,0,0]
        }
        var arr = (bint2Data(bint: BInt(value))?.bytes)!
        while (arr.count < 8){
            arr = [0] + arr
        }
        return arr
        
    }

    
    public static func fromByteArray<T>(_ value: [UInt8], _: T.Type) -> T {
        return value.withUnsafeBytes {
            $0.baseAddress!.load(as: T.self)
        }
    }
    
    private static func fromHexStringToBInt (nStr: String, radix: Int) -> BInt?{
        var useString = nStr
        if radix == 16 {
            if useString.hasPrefix("0x") {
                useString = String(nStr.dropFirst(2))
            }
        }
        
        if radix == 8 {
            if useString.hasPrefix("0o") {
                useString = String(nStr.dropFirst(2))
            }
        }
        
        if radix == 2 {
            if useString.hasPrefix("0b") {
                useString = String(nStr.dropFirst(2))
            }
        }
        
        let bint16 = BInt(radix)
        
        var total = BInt(0)
        var exp = BInt(1)
        
        for c in useString.reversed() {
            let int = Int(String(c), radix: radix)
            if int != nil {
                let value = BInt(int!)
                total = total + (value * exp)
                exp = exp * bint16
            } else {
                return nil
            }
            
        }
        
        return BInt(String(describing: total))
    }
}

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
