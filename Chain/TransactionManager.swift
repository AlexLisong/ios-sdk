//
//  TransactionManager.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation
import EthereumKit

public class TransactionManager {
    
    private let TIP_DEFAULT: Int32 = 0
    
    public static func newTransaction(){

    }
    private func buildVin(transaction: Transaction, utxos: [Utxo], wallet: Wallet) -> BInt{
        var txInput: TXInput
        let pubKey = wallet.publicKey()
        var totalAmount: BInt = 0
        /*for u in utxos{
            //txInput = TXInput.init(txid: u.txid, pubKey: u.publicKeyHash)
        }*/
        return totalAmount
        
    }
    private func printDebugInformation() {

    }
}
