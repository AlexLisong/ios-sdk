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
import CryptoSwift
import CryptoEthereumSwift
import EthereumKit
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
    }

    public func send(from: String, parcel: Parcel, privateKey: Data) -> String{
        var request = Rpcpb_SendTransactionRequest.init()
        request.transaction = TransactionManager.newTransaction(utxos: getUtxos(address: from), parcel: parcel, privateKey: privateKey).toProto()
        let response = try? self.serviceClient.rpcSendTransaction(request)
        return "Return code: \(response?.errorCode)" ?? "RPC error: response is empty"
    }
    public func getUtxos(address: String) -> [Utxo]{
        
        var request = Rpcpb_GetUTXORequest.init()
        request.address = address
        
        let response = try? self.serviceClient.rpcGetUTXO(request)
        var utxoList = [Utxo]()
        for u in response!.utxos{
            utxoList.append(Utxo(amount: u.amount,publicKeyHash: u.publicKeyHash,txid: u.txid,txIndex: Int32(u.txIndex)))
        }
        return utxoList
    }
//    public func getBlocks() -> Int{
//        var request = Rpcpb_GetBlocksRequest.init()
//        request.maxCount = 20
//        let response = try? self.serviceClient.rpcGetBlocks(request)
//        return response?.blocks.count ?? -1
//    }
    
    public func getBalance(address: String) -> Int64{
        var request = Rpcpb_GetBalanceRequest.init()
        request.address = address
        request.name = "getBalance"
        let response = try? serviceClient.rpcGetBalance(request)
        return response?.amount ?? -1
    }
    
//    public func getBlockByHeight() -> Int{
//        var request = Rpcpb_GetBlockByHeightRequest()
//        request.height = 1
//        let response = try? serviceClient.rpcGetBlockByHeight(request)
//        return (response?.block.hashValue)!
//    }
    
    public func getBlockchainInfo() -> UInt64{
        let request = Rpcpb_GetBlockchainInfoRequest.init()
        let response = try? serviceClient.rpcGetBlockchainInfo(request)
        return response?.blockHeight ?? 0
    }
}
    
