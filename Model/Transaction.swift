//
//  Transaction.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation
import EthereumKit

public struct Transaction {
    
    public var id: Data = Data()
    
    public var vin: [TXInput] = []
    
    public var vout: [TXOutput] = []
    
    public var tip: BInt = 0
    
    public init() {
        
    }
    public init(vin: [TXInput], vout: [TXOutput], tip: BInt) {
        self.tip = tip
        self.vin = vin
        self.vout = vout
        self.id = self.hash()
    }
    public mutating func sign(privateKey : Data, utxos : [Utxo]) {
        
        let utxoMap = Utxo.getPrevUtxos(utxos: utxos)
        
        let transactionCopy = self.trimedCopy();
        
        buildSignValue(utxoMap: utxoMap, transactionCopy: transactionCopy, privKey: privateKey);
    }
    internal func toProto() -> Corepb_Transaction{
        var transaction = Corepb_Transaction()
        transaction.id = self.id
        for v in self.vin{
        transaction.vin.append(v.toProto())
        }
        for v in self.vout{
        transaction.vout.append(v.toProto())
        }
        transaction.tip = DataUtil.bint2Data(bint: self.tip)!
        return transaction
    }
    private mutating func buildSignValue(utxoMap : Dictionary<String, Utxo>,transactionCopy : Transaction, privKey: Data) {
        var tranCopy = transactionCopy
        var txCopyInputs = tranCopy.vin
        var txCopyInput = TXInput()
        var oldPubKey = Data()
        for (index, _) in txCopyInputs.enumerated() {
            txCopyInput = txCopyInputs[index]
            oldPubKey = txCopyInput.pubKey
            let utxo = utxoMap[txCopyInput.txid.toHexString() + "-" + String(txCopyInput.vout)]

            tranCopy.vin[index].pubKey = (utxo?.publicKeyHash)!
            // get deepClone's hash value
            let txCopyHash = tranCopy.hash()
            // recover old pubKey
            tranCopy.vin[index].pubKey = oldPubKey

            let signature = HashUtil.secp256k1Sign(hash: txCopyHash, privateKey: privKey)
            // Update original transaction data with vin's signature.
            self.vin[index].setSignature(signature: signature!)
        }
    }
    

    public func serialized() -> Data {
        var data = Data()
        data += vin.flatMap { $0.serialized() }
        data += vout.flatMap { $0.serialized() }
        data += DataUtil.bint2Data(bint: tip)!
        return data
    }
   
    public func hash() -> Data{
        let hash = serialized().sha256();
        return hash;
    }
    
    public func deepClone() -> Transaction{
        var transaction = Transaction();
        transaction.id = self.id
        
        // deep clone list datas
        if (self.vin.count > 0) {
            transaction.vin = [TXInput]()
            var txNewInput: TXInput
            for a in self.vin {
                
                txNewInput = TXInput()
                txNewInput.txid = a.txid
                txNewInput.pubKey = a.pubKey
                txNewInput.setSignature(signature: a.signature)
                txNewInput.vout = a.vout
                transaction.vin.append(txNewInput)
            }
        }
        
        if (self.vout.count > 0) {
            var txNewOutput = TXOutput()
            for u in self.vout {
                txNewOutput = TXOutput();
                txNewOutput.pubKeyHash = u.pubKeyHash
                txNewOutput.value = u.value
                transaction.vout.append(txNewOutput)
            }
        }
        
        transaction.tip = self.tip
        return transaction;
    }
    
    public func trimedCopy() -> Transaction{
        var newTransaction = self.deepClone();
        for (index, _) in newTransaction.vin.enumerated(){
            // clear pubKey and signature
            newTransaction.vin[index].pubKey = Data()
            newTransaction.vin[index].signature = Data()
        }
        return newTransaction;
    }
    
}


