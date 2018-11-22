//
//  RpcProvider.swift
//  DappleySwift
//
//  Created by Li Song on 2018-11-09.
//  Copyright © 2018 Li Song. All rights reserved.
//

import Foundation
import SwiftProtobuf
import SwiftGRPC
import BitcoinKit
import BitcoinKit.Private
import CryptoSwift
public struct RpcProvider {
    public let host: String
    public let secure: Bool
    let channel: Channel
    let serviceClient: Rpcpb_RpcServiceServiceClient
    let adminClient: Rpcpb_AdminServiceServiceClient
    let defaultTimeout: TimeInterval = 0.5

    /**
     Creates a new instance of `RpcProvider`.
     /// - Parameter address: the address of the server to be called
     /// - Parameter secure: Optional, if true, use TLS
     */
    public init(host: String,
                secure: Bool = false) {
        self.host = host
        self.secure = secure
        self.channel = Channel(address: host, secure: false)
        self.serviceClient = Rpcpb_RpcServiceServiceClient.init(channel: self.channel)
        self.adminClient =  Rpcpb_AdminServiceServiceClient.init(channel: self.channel)

        //let ctx = secp256k1_context_create(SECP256K1_CONTEXT_SIGN)
        //secp256k1_context *ctx = secp256k1_context_create(SECP256K1_CONTEXT_SIGN);

    }
    /*
    public func sign(hash: Data, privateKey: Data) -> secp256k1_ecdsa_recoverable_signature? {
        precondition(hash.count == 32, "Hash must be 32 bytes size")
        var signature = secp256k1_ecdsa_recoverable_signature()
        let status = privateKey.withUnsafeBytes { (key: UnsafePointer<UInt8>) in
            hash.withUnsafeBytes { secp256k1_ecdsa_sign_recoverable(context, &signature, $0, key, nil, nil) }
        }
        return status == 1 ? signature : nil
    }*/
    public func testSign() {
        let pk = Data(hex: "300c0338c4b0d49edc66113e3584e04c6b907f9ded711d396d522aae6a79be1a")!
        let msg = Crypto.sha256("hello world".data(using: .ascii)!)
        print("msg: \(msg.hex)")
        let privateKey = PrivateKey(data: pk)
        // let signature = try? sign(msg, privateKey: privateKey)
       // let signature = try CryptoEthereumSwift.Crypto.sign(msg, privateKey: privateKey)
        
        print(privateKey.raw.hex)
        //XCTAssertNotNil(signature)
        //XCTAssertEqual(signature?.hex, "cd7c36f9cf69feb13f75859382fcdc2ac6c97d9c13dbbe42dc4ceb7eb29f454b101528db47edb53ce7cffc99f251e47ecfa689fc6730de7aae7ba540e64d672f01")
    }
    
    public func Send(from: String, to: String, amount: Data) -> String{

        var vin = Corepb_TXInput.init()
        
        var vout = Corepb_TXOutput.init()
        vout.contract = "some contract"
//        guard let keyPair = try? Cryptography.createKeyPair() else {
//            fatalError("Wallet could not be initialized because the key generation failed.")
//        }
        
        var transaction = Corepb_Transaction.init()
        transaction.tip = 1
        //transaction.vin = [vin]
        transaction.vout = [vout]
        /*
        var request = Rpcpb_SendRequest.init()
        request.from = from
        request.to = to
        request.amount = amount
        let response = try? self.adminClient.rpcSend(request)
        */
        
        var request = Rpcpb_SendTransactionRequest.init()
        request.transaction = transaction
        
        
        let response = try? self.serviceClient.rpcSendTransaction(request)

       // print("rpcSend:\(response?.message)")
       
        //return response?.message ?? ""
        return ""
    }
    
    public func GetBlocks() -> Int{
        var request = Rpcpb_GetBlocksRequest.init()
        request.maxCount = 20
        
        let response = try? self.serviceClient.rpcGetBlocks(request)
       // print(response?.blocks[0].header.hash)

        print(response?.blocks[0].header.hash)
        print(response?.blocks[0].header.timestamp)
        print(response?.blocks[0].transactions[0].vout[0].value)

        return response?.blocks.count ?? 0
    }
    
    public func GetBalance(address: String) -> Int64{
        var request = Rpcpb_GetBalanceRequest.init()
        request.address = address
        request.name = "getBalance"
        let response = try? serviceClient.rpcGetBalance(request)
        print(response?.message)
        return response?.amount ?? -1
    }
    
    public func GetBlockByHeight() -> Int{
        var request = Rpcpb_GetBlockByHeightRequest()
        request.height = 1
        let response = try? serviceClient.rpcGetBlockByHeight(request)
        for transaction in (response?.block.transactions)!{
            print(transaction.tip)
            print(transaction.id)
            for vout in transaction.vout{
                print(vout.contract)
                print(vout.pubKeyHash)
                
            }
        }
        return (response?.block.hashValue)!
    }
    
    public func GetBlockchainInfo() -> UInt64{
        let privateKey = PrivateKey(network: .testnet) // You can choose .mainnet or .testnet
        let wallet = Wallet(privateKey: privateKey)
        print("wallet \(wallet.publicKey)")
        
        let request = Rpcpb_GetBlockchainInfoRequest.init()
        let response = try? serviceClient.rpcGetBlockchainInfo(request)
        return response?.blockHeight ?? 0
    }
    public func Secp256k1(){
        //public static void testSecp256k1() throws UnsupportedEncodingException {
        //let privateKey = "f00fbae3a1ecd3de06be15cc455443fcf275008a04c1f69689a2f670f6f49c5b"
       // let sig = Crypto.sign(Data, privateKey: privateKey.data(using: <#T##String.Encoding#>))
        //let hash = Crypto.sha256(entropy)

        // let privateKeyBytes = BigNumber.init(privateKey)//  HashUtil.fromECDSAPrivateKey(new BigInteger(privateKey, 16));

       /* let privateKeyBytes =  HashUtil.fromECDSAPrivateKey(new BigInteger(privateKey, 16));
        let hello_string = "hello world";
            byte[] data = hello_string.getBytes("UTF-8");
            data = ShaDigest.sha256(data);
            byte[] sign = HashUtil.secp256k1Sign(data, privateKeyBytes);
            String signValue = HexUtil.toHex(sign);
            System.out.println(signValue);*/
       // }
        /*
        let ctx = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN))!;
        var signature : secp256k1_ecdsa_signature;
        var normalizedSignature : secp256k1_ecdsa_signature;
        let message = Data(base64Encoded:"hello world")
        let msgdata = Crypto.sha256(message!);

        secp256k1_ecdsa_sign(ctx, &signature, msgdata, privateKey.bytes, NULL, NULL);
         secp256k1_ecdsa_signature_normalize(ctx, normalizedSignature, signature);
         let siglen = 74;
         let der = NSMutableData.init(siglen)// dataWithLength:siglen];
         secp256k1_ecdsa_signature_serialize_der(ctx, der.mutableBytes, siglen, normalizedSignature);
         der.length = siglen
         secp256k1_context_destroy(ctx);
         //return der;*/
    }
}
    
