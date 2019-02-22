//
//  ViewController.swift
//  DigitalSignature
//
//  Created by Mithilesh Singh on 20/02/19.
//  Copyright © 2019 Mithilesh Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func testEncryption(message: String, encryptionKey: String, hmacKey: String) {
        let encryptedTouple = message.toBase64AES128(key: encryptionKey)
        let hash = message.hmac(algorithm: .SHA256, key: hmacKey)
        print(encryptedTouple.0 ?? "Could not encrypt")
        print(encryptedTouple.1 ?? "No IV String")
        print(hash)
    }
    
    private func testDecryption(message: String, encryptionKey: String, hmacKey: String, iv: String) {
        let decryptedMessage = message.fromBase64AES128(key: encryptionKey, iv: iv)
        let hash = decryptedMessage?.hmac(algorithm: .SHA256, key: hmacKey)
        print(decryptedMessage ?? "Could not decrypt")
        print(hash ?? "Could not generate hash")
    }
}

