//
//  Data+Bytes.swift
//  NiYO
//
//  Created by Mithilesh Singh on 31/12/18.
//  Copyright © 2018 NiYO. All rights reserved.
//

import Foundation

extension Data {
    init<T>(fromArray values: [T]) {
        var values = values
        self.init(buffer: UnsafeBufferPointer(start: &values, count: values.count))
    }
    
    func toArray<T>(type: T.Type) -> [T] {
        return self.withUnsafeBytes {
            [T](UnsafeBufferPointer(start: $0, count: self.count/MemoryLayout<T>.stride))
        }
    }
    
    func generateRandomBytes(size: Int) -> Data? {
        var ivData = Data(count: size)
        var localData = ivData
        let status = localData.withUnsafeMutableBytes { ivBytes in
            SecRandomCopyBytes(kSecRandomDefault, ivData.count, ivBytes)
        }
        if status == errSecSuccess {
            return localData
        }
        return nil
    }
}
