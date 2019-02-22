//
//  String+AES.swift
//  TestApp
//
//  Created by Mithilesh Singh on 27/12/18.
//  Copyright © 2018 Mithilesh Singh. All rights reserved.
//

import Foundation

extension String {
    func toBase64AES128(key: String) -> (String?, String?) {
        guard let keyData = Data(base64Encoded: key) else {
            return (nil, nil)
        }
        let plainData = self.data(using: .utf8)
        guard let encryptedData = plainData?.toAES128(keyData: keyData) else {
            return (nil, nil)
        }
        return (encryptedData.0?.base64EncodedString(), encryptedData.1?.base64EncodedString())
    }
    
    func fromBase64AES128(key: String, iv: String) -> String? {
        guard let keyData = Data(base64Encoded: key), let ivData = Data(base64Encoded: iv) else {
            return nil
        }
        let plainData = Data(base64Encoded: self)
        guard let decryptedData = plainData?.fromAES128(keyData: keyData, ivData: ivData) else {
            return nil
        }
        return String(data: decryptedData, encoding: .utf8)
    }
}
