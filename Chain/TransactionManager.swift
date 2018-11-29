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
    
    private static let TIP_DEFAULT: UInt64 = 1
    
    public static func newTransaction(utxos: [Utxo], toAddress: String, amount: BInt, privateKey: Data) -> Transaction{
        let publicKey = HashUtil.GetPublicKey(privateKey: privateKey)
        let (totalAmount, inputList) = buildVin(utxos: utxos, publicKey: publicKey)
        let outputList = buildVout(toAddress: toAddress, amount: amount, totalAmount: totalAmount, publicKey: publicKey)
        
        var transaction = Transaction.init(vin: inputList, vout: outputList, tip: TIP_DEFAULT)
        transaction.sign(privateKey: privateKey, utxos: utxos)
        return transaction
    }
    private static func buildVin(utxos: [Utxo], publicKey: Data) -> (BInt, [TXInput]){
        var txInput: TXInput
        var totalAmount: BInt = 0
        var inputList: [TXInput] = [TXInput]()
        for u in utxos{
            txInput = TXInput.init(txid: u.txid, vout: u.txIndex, pubKey: publicKey)
            totalAmount += u.amount
            inputList.append(txInput)
        }
        return (totalAmount,inputList)
        
    }
    private static func buildVout(toAddress: String, amount: BInt, totalAmount: BInt, publicKey: Data) -> [TXOutput]{
        var outputList: [TXOutput] = [TXOutput]()
        
        var txOutput = TXOutput(value: amount, pubKeyHash: HashUtil.getPublicKeyHash(address: toAddress), contract: "")
        
        outputList.append(txOutput)
        
        if(totalAmount > amount){
            txOutput = TXOutput(value: totalAmount - amount, pubKeyHash: HashUtil.getPublicKeyHash(publicKey: publicKey), contract: "")
            outputList.append(txOutput)
        }
        return outputList
    }
    
}

