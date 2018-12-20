//
//  ViewController.swift
//  sodiumTest
//
//  Created by Ahmed Sengab on 9/14/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
import Sodium

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*let sodium = Sodium()
        let aliceKeyPair = sodium.box.keyPair()
        print(aliceKeyPair?.publicKey.base64EncodedString())
        print(aliceKeyPair?.secretKey.base64EncodedString())
        // Do any additional setup after loading the view, typically from a nib.*/
        
        /*let sodium = Sodium()
        let aliceKeyPair = sodium.keyExchange.keyPair()!
        let bobKeyPair = sodium.keyExchange.keyPair()!
        
        let sessionKeyPairForAlice = sodium.keyExchange.sessionKeyPair(publicKey: aliceKeyPair.publicKey,
                                                                       secretKey: aliceKeyPair.secretKey, otherPublicKey: bobKeyPair.publicKey, side: .CLIENT)!
        let sessionKeyPairForBob = sodium.keyExchange.sessionKeyPair(publicKey: bobKeyPair.publicKey,
                                                                     secretKey: bobKeyPair.secretKey, otherPublicKey: aliceKeyPair.publicKey, side: .SERVER)!
        
        let aliceToBobKeyEquality = sodium.utils.equals(sessionKeyPairForAlice.tx, sessionKeyPairForBob.rx) // true
        let bobToAliceKeyEquality = sodium.utils.equals(sessionKeyPairForAlice.rx, sessionKeyPairForBob.tx) // true*/
        
       /* let sodium = Sodium()
        let aliceKeyPair = sodium.box.keyPair()
        let bobKeyPair = sodium.box.keyPair()
        let message = "My Test Message".data(using: .utf8)
        
        let encryptedMessageFromAliceToBob : Data =
            sodium.box.seal(message: message!,
                            recipientPublicKey: (bobKeyPair?.publicKey)!,
                            senderSecretKey: (aliceKeyPair?.secretKey)!)!
        
        let messageVerifiedAndDecryptedByBob =
            sodium.box.open(nonceAndAuthenticatedCipherText: encryptedMessageFromAliceToBob,
                            senderPublicKey: (aliceKeyPair?.publicKey)!,
                            recipientSecretKey: (bobKeyPair?.secretKey)!)*/
        
        let sodium = Sodium()
        let aliceKeyPair = sodium.keyExchange.keyPair()!
        let bobKeyPair = sodium.keyExchange.keyPair()!
        
        let sessionKeyPairForAlice = sodium.keyExchange.sessionKeyPair(publicKey: aliceKeyPair.publicKey,
                                                                       secretKey: aliceKeyPair.secretKey, otherPublicKey: bobKeyPair.publicKey, side: .CLIENT)!
        let sessionKeyPairForBob = sodium.keyExchange.sessionKeyPair(publicKey: bobKeyPair.publicKey,
                                                                     secretKey: bobKeyPair.secretKey, otherPublicKey: aliceKeyPair.publicKey, side: .SERVER)!
        
        let aliceToBobKeyEquality = sodium.utils.equals(sessionKeyPairForAlice.tx, sessionKeyPairForBob.rx) // true
        let bobToAliceKeyEquality = sodium.utils.equals(sessionKeyPairForAlice.rx, sessionKeyPairForBob.tx)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

