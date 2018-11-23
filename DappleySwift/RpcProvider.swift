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

    public func Send(from: String, to: String, amount: Data) -> String{
        var request = Rpcpb_SendRequest.init()
        request.from = from
        request.to = to
        request.amount = amount
        let response = try? self.adminClient.rpcSend(request)
        
        print("rpcSend:\(response?.message)")
       
        return response?.message ?? ""
        
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
        return (response?.block.hashValue)!
    }
    
    public func GetBlockchainInfo() -> UInt64{
        let request = Rpcpb_GetBlockchainInfoRequest.init()
        let response = try? serviceClient.rpcGetBlockchainInfo(request)
        return response?.blockHeight ?? 0
    }
}
    
