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
    
    public static func newTransaction(utxos: [Utxo], parcel: Parcel, privateKey: Data) -> Transaction{
        let publicKey = HashUtil.getPublicKey(privateKey: privateKey)
        var (totalAmount, inputList) = buildVin(utxos: utxos, publicKey: publicKey)
        totalAmount = totalAmount - parcel.tip
        let outputList = buildVout(parcel:parcel, totalAmount: totalAmount, publicKey: publicKey)
        
        var transaction = Transaction.init(vin: inputList, vout: outputList, tip: parcel.tip)
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
    private static func buildVout(parcel: Parcel, totalAmount: BInt, publicKey: Data) -> [TXOutput]{
        var outputList: [TXOutput] = [TXOutput]()
        var txOutput = TXOutput(value: parcel.value, pubKeyHash: AddressUtil.getPublicKeyHash(address: parcel.toAddress), contract: parcel.contract)
        
        outputList.append(txOutput)
        
        if(totalAmount > parcel.value){
            let left = totalAmount - parcel.value
            txOutput = TXOutput(value: left, pubKeyHash: HashUtil.getPublicKeyHash(publicKey: publicKey), contract: "")
            outputList.append(txOutput)
        }
        return outputList
    }
    
}

