//
//  RpcTests.swift
//  DappleySwiftTests
//
//  Created by Li Song on 2018-11-20.
//  Copyright © 2018 Alex Song. All rights reserved.
//

import XCTest
@testable import BitcoinKit


class CryptoTests: XCTestCase {
    func testSHA256() {
        /* Usually, when a hash is computed within bitcoin, it is computed twice.
         Most of the time SHA-256 hashes are used, however RIPEMD-160 is also used when a shorter hash is desirable
         (for example when creating a bitcoin address).

         https://en.bitcoin.it/wiki/Protocol_documentation#Hashes
         */
        XCTAssertEqual(Crypto.sha256("hello".data(using: .ascii)!).hex, "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824")
        XCTAssertEqual(Crypto.sha256sha256("hello".data(using: .ascii)!).hex, "9595c9df90075148eb06860365df33584b75bff782a510c6cd4883a419833d50")
    }

    func testSHA256RIPEMD160() {
        XCTAssertEqual(Crypto.sha256ripemd160("hello".data(using: .ascii)!).hex, "b6a9c8c230722b7c748331a8b450f05566dc7d0f")
    }
    /*
    func sign(_ data: Data, privateKey: PrivateKey) throws -> Data {
        let ctx = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN))!
        defer { secp256k1_context_destroy(ctx) }
        
        let signature = UnsafeMutablePointer<secp256k1_ecdsa_signature>.allocate(capacity: 1)
        defer { signature.deallocate() }
        let status = data.withUnsafeBytes { (ptr: UnsafePointer<UInt8>) in
            privateKey.raw.withUnsafeBytes { secp256k1_ecdsa_sign(ctx, signature, ptr, $0, nil, nil) }
        }
        guard status == 1 else { throw CryptoError.signFailed }
        
        let normalizedsig = UnsafeMutablePointer<secp256k1_ecdsa_signature>.allocate(capacity: 1)
        defer { normalizedsig.deallocate() }
        secp256k1_ecdsa_signature_normalize(ctx, normalizedsig, signature)
        
        var length: size_t = 128
        var der = Data(count: length)
        guard der.withUnsafeMutableBytes({ return secp256k1_ecdsa_signature_serialize_der(ctx, $0, &length, normalizedsig) }) == 1 else { throw CryptoError.noEnoughSpace }
        der.count = length
        
        
    */
        
        /*
         if len(msg) != 32 {
         return nil, ErrInvalidMsgLen
         }
         
         if C.secp256k1_ec_seckey_verify(ctx, cBuf(seckey)) != 1 {
         return nil, ErrInvalidPrivateKey
         }
         
         var (
         noncefunc = C.secp256k1_nonce_function_rfc6979
         sigstruct C.secp256k1_ecdsa_recoverable_signature
         )
         if C.secp256k1_ecdsa_sign_recoverable(ctx, &sigstruct, cBuf(msg), cBuf(seckey), noncefunc, nil) == 0 {
         return nil, ErrSignFailed
         }
         
         var (
         sig   = make([]byte, 65)
         recid C.int
         )
         C.secp256k1_ecdsa_recoverable_signature_serialize_compact(ctx, cBuf(sig), &recid, &sigstruct)
         sig[64] = byte(recid) // add back recid to get 65 bytes sig
         return sig, nil
         */
        
        //return der
    //}
    /*func testSign() {
        let pk = Data(hex: "300c0338c4b0d49edc66113e3584e04c6b907f9ded711d396d522aae6a79be1a")!
        let msg = Crypto.sha256("hello world".data(using: .ascii)!)
        print("msg: \(msg.hex)")
        let privateKey = PrivateKey(data: pk)
       // let signature = try? sign(msg, privateKey: privateKey)
        let signature = try CryptoEthereumSwift.Crypto.sign(msg, privateKey: privateKey)

        print(privateKey.raw.hex)
        XCTAssertNotNil(signature)
        XCTAssertEqual(signature?.hex, "cd7c36f9cf69feb13f75859382fcdc2ac6c97d9c13dbbe42dc4ceb7eb29f454b101528db47edb53ce7cffc99f251e47ecfa689fc6730de7aae7ba540e64d672f01")
    }*/
}

