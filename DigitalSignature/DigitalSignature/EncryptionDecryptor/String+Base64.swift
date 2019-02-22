//
//  String+Base64.swift
//  TestApp
//
//  Created by Mithilesh Singh on 27/12/18.
//  Copyright © 2018 Mithilesh Singh. All rights reserved.
//

import Foundation

extension String {
    func toBase64() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        return data.base64EncodedString()
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
}
