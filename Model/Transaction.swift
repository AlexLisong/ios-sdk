//
//  Transaction.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-23.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import Foundation
public struct Transaction {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
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
        
        // format previous transaction data
        let utxoMap = Utxo.getPrevUtxos(utxos: utxos)
        
        // get a trimedCopy of old transaction
        let transactionCopy = self.trimedCopy();
        
        //byte[] privKeyBytes = HashUtil.fromECDSAPrivateKey(privateKey);
        
        // calculate sign value
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
        transaction.tip = self.tip
        return transaction
    }
    private mutating func buildSignValue(utxoMap : Dictionary<String, Utxo>,transactionCopy : Transaction, privKey: Data) {
        
        var txCopyInputs = transactionCopy.vin
        var txCopyInput = TXInput()
        var oldPubKey = Data()
        for (index, _) in txCopyInputs.enumerated() {
            txCopyInput = txCopyInputs[index]
            oldPubKey = txCopyInput.pubKey //txCopyInput.getPubKey();
            let utxo = utxoMap[txCopyInput.txid.toHexString() + "-"]
            // temporarily add pubKeyHash to pubKey property
            txCopyInput.pubKey = (utxo?.publicKeyHash)! //.setPubKey(utxo.getPublicKeyHash());
            
            // get deepClone's hash value
            let txCopyHash = transactionCopy.hash();
            
            // recover old pubKey
            txCopyInput.pubKey = oldPubKey //(oldPubKey);
            
            let signature = HashUtil.Secp256k1Sign(hash: txCopyHash, privateKey: privKey);
            
            // Update original transaction data with vin's signature.
            self.vin[index].setSignature(signature: signature!);
        }
    }
    

    public func serialized() -> Data {
        var data = Data()
        data += vin.flatMap { $0.serialized() }
        data += vout.flatMap { $0.serialized() }
        data += Data(withUnsafeBytes(of: tip) { Data($0) })
        return data
    }
    
    public func hash() -> Data{
        //let oldId = self.id
        // clear id property
        //self.id = Data()
        // get sha256 hash
        let hash = serialized().sha256();
        //self.id = oldId
        return hash;
    }
    
    /**
     * Got a deep clone object of this one.
     * @return Transaction copied transaction
     */
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
                transaction.vout.append(txNewOutput)
            }
        }
        
        transaction.tip = self.tip
        return transaction;
    }
    
    /**
     * trimedCopy creates a trimmed deepClone of Transaction to be used in signing
     * @return Transaction new transaction
     */
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


