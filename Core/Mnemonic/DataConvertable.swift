//
//  DataConvertable.swift
//  DappleySwift
//
//  Created by Li Song on 2019-01-19.
//  Copyright © 2019 Alex Song. All rights reserved.
//
import Foundation

extension String {
    func toData() -> Data {
        return decomposedStringWithCompatibilityMapping.data(using: .utf8)!
    }
}
