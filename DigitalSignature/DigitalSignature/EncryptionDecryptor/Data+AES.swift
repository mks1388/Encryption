//
//  Data+AES.swift
//  TestApp
//
//  Created by Mithilesh Singh on 27/12/18.
//  Copyright © 2018 Mithilesh Singh. All rights reserved.
//

import Foundation
import CommonCrypto

extension Data {
    func fromAES128(keyData: Data, ivData:Data) -> Data? {
        return AES128(keyData: keyData, ivData: ivData, operation: kCCDecrypt).0
    }
    
    func toAES128(keyData: Data) -> (Data?, Data?) {
        guard let ivData = generateRandomBytes(size: kCCBlockSizeAES128) else {
            return (nil, nil)
        }
        return AES128(keyData: keyData, ivData: ivData, operation: kCCEncrypt)
    }
    
    //MARK: private functions
    
    private func AES128(keyData: Data, ivData:Data, operation: Int) -> (Data?, Data?) {
        
        let cryptLength  = size_t(self.count + kCCBlockSizeAES128)
        var cryptData = Data(count:cryptLength)
        
        let keyLength = size_t(kCCKeySizeAES128)
        let options = CCOptions(kCCOptionPKCS7Padding)
        
        var numBytesEncrypted :size_t = 0

        let cryptStatus = cryptData.withUnsafeMutableBytes {cryptBytes in
            self.withUnsafeBytes {dataBytes in
                ivData.withUnsafeBytes({ ivBytes in
                    keyData.withUnsafeBytes {keyBytes in
                        CCCrypt(CCOperation(operation),
                                CCAlgorithm(kCCAlgorithmAES),
                                options,
                                keyBytes, keyLength,
                                ivBytes,
                                dataBytes, self.count,
                                cryptBytes, cryptLength,
                                &numBytesEncrypted)
                    }
                })
            }
        }
        
        assert(cryptStatus == CCCryptorStatus(kCCSuccess), "Encryption/Decryption status is not success.")
        
        if cryptStatus == CCCryptorStatus(kCCSuccess) {
            cryptData.removeSubrange(numBytesEncrypted..<cryptData.count)
        }
        
        return (cryptData, ivData)
    }
}
