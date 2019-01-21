//
//  WordList.swift
//  DappleySwift
//
//  Created by Li Song on 2019-01-19.
//  Copyright © 2019 Alex Song. All rights reserved.
//

public enum WordDict{
    case english
    case chinese
    public var words: [String] {
        switch self {
        case .english:
            return englishWords
        case .chinese:
            return chineseWords
        }
    }
}
