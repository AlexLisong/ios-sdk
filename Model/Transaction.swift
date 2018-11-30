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
    
    public var tip: UInt64 = 0
    
    public init() {
        
    }
    public init(vin: [TXInput], vout: [TXOutput], tip: UInt64) {
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
        print("transaction id :\(transaction.id.bytes)")
        for v in self.vin{
        transaction.vin.append(v.toProto())
            print("v sig: \(v.signature.bytes)")
            print("v id: \(v.txid.bytes)")
           print("v pub: \(v.pubKey.bytes)")
        }
        for v in self.vout{
        transaction.vout.append(v.toProto())
        }
        transaction.tip = self.tip
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
            print("key key\(txCopyInput.txid.toHexString() + "-" + String(txCopyInput.vout))")
            print("utxo \(utxo?.txid)")
            print("vin id: \(tranCopy.vin[index].txid.bytes)")
            // temporarily add pubKeyHash to pubKey property
            //txCopyInput.pubKey = (utxo?.publicKeyHash)!
            
            tranCopy.vin[index].pubKey = (utxo?.publicKeyHash)!
            //print("new pub: \(txCopyInput.pubKey.bytes)")
            // get deepClone's hash value
            let txCopyHash = tranCopy.hash()
            print("copy hash: \(tranCopy.hash())")
            // recover old pubKey
            //txCopyInput.pubKey = oldPubKey
            tranCopy.vin[index].pubKey = oldPubKey

            let signature = HashUtil.Secp256k1Sign(hash: txCopyHash, privateKey: privKey)
            print("pr: \(privKey.bytes)signature: \(signature?.bytes)")
            // Update original transaction data with vin's signature.
            self.vin[index].setSignature(signature: signature!)
        }
    }
    

    public func serialized() -> Data {
        var data = Data()
        data += vin.flatMap { $0.serialized() }
        print("data: -- vin\(data.bytes)")
        data += vout.flatMap { $0.serialized() }
        print("data: -- vout\(data.bytes)")
        data += Data(bytes: DataUtil.UInt64toByteArray(value: tip))
        print("data: -- vdata\(data.bytes)")
        return data
    }
    /*
    for _, vin := range tx.Vin {
    bytes = append(bytes, vin.Txid...)
    // int size may differ from differnt platform
    bytes = append(bytes, byteutils.FromInt32(int32(vin.Vout))...)
    bytes = append(bytes, vin.PubKey...)
    bytes = append(bytes, vin.Signature...)
    }
    
    for _, vout := range tx.Vout {
    bytes = append(bytes, vout.Value.Bytes()...)
    bytes = append(bytes, vout.PubKeyHash.GetPubKeyHash()...)
    }
    
    bytes = append(bytes, byteutils.FromUint64(tx.Tip)...)
    
    */
    
    public func hash() -> Data{
        //let oldId = self.id
        // clear id property
        //self.id = Data()
        // get sha256 hash
        let hash = serialized().sha256();
        //self.id = oldId
        return hash;
    }
    
    public func deepClone() -> Transaction{
        var transaction = Transaction();
        transaction.id = self.id//.setId(this.id.clone());
        
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
                print(u.value.description)
                print(txNewOutput.value.description)
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


