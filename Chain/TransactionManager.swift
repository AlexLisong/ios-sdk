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
        return transaction
    }
    private static func buildVin(utxos: [Utxo], publicKey: Data) -> (BInt, [TXInput]){
        var txInput: TXInput
        var totalAmount: BInt = 0
        var inputList: [TXInput] = [TXInput]()
        for u in utxos{
            txInput = TXInput.init(txid: u.txid, vout: u.txIndex, pubKey: u.publicKeyHash)
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
    
    
    
    public static func getPrevUtxos(utxos: [Utxo]) -> Dictionary<String, Utxo>{
        var utxoMap = Dictionary<String,Utxo>()
        for u in utxos {
            utxoMap[u.txid.toHexString() + "-" + String(u.txIndex)] = u
        }
        return utxoMap;
    }
    
    public static func sign(transaction: Transaction,privateKey : Data, utxos : [Utxo]) {
        
        // format previous transaction data
        let utxoMap = getPrevUtxos(utxos: utxos)
        
        // get a trimedCopy of old transaction
        let transactionCopy = transaction.trimedCopy();
        
        //byte[] privKeyBytes = HashUtil.fromECDSAPrivateKey(privateKey);
        
        // calculate sign value
        buildSignValue(transaction: transaction, utxoMap: utxoMap, transactionCopy: transactionCopy, privKey: privateKey);
    }
    
    
    private static func buildSignValue(transaction : Transaction,utxoMap : Dictionary<String, Utxo>,transactionCopy : Transaction, privKey: Data) {
        
        var txCopyInputs = transactionCopy.vin
        var txCopyInput = TXInput()
        var oldPubKey = Data()
        for (index, ele) in txCopyInputs.enumerated() {
            txCopyInput = txCopyInputs[index]
            oldPubKey = txCopyInput.pubKey //txCopyInput.getPubKey();
            let utxo = utxoMap[txCopyInput.txid.toHexString() + "-"]
            // temporarily add pubKeyHash to pubKey property
            txCopyInput.pubKey = (utxo?.publicKeyHash)! //.setPubKey(utxo.getPublicKeyHash());
            
            // get deepClone's hash value
            let txCopyHash = transactionCopy.hash();
            
            // recover old pubKey
            txCopyInput.pubKey = oldPubKey //(oldPubKey);
            
            var signature = HashUtil.Secp256k1Sign(hash: txCopyHash, privateKey: privKey);
            
            // Update original transaction data with vin's signature.
            transaction.vin[index].setSignature(signature);
        }
    }
    
}

