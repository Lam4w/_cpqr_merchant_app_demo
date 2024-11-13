//
//  KeyUtils.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 08/11/2024.
//

import Foundation
import Security
import CryptoKit
import JOSESwift
import SwiftyRSA

class KeyUtils {
    class func readPrivateKey(from path: String) throws -> SecKey? {
        let url = URL(fileURLWithPath: path)
        let keyData = try Data(contentsOf: url)
        guard var keyString = String(data: keyData, encoding: .utf8) else {
            print("Error: Invalid file encoding")
            throw NSError(domain: "Invalid file encoding", code: -1, userInfo: nil)
        }
        
        print(keyString)
        
        keyString = keyString
            .replacingOccurrences(of: "-----BEGIN RSA PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "-----END RSA PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "\n", with: "")
        
        guard let decodedData = Data(base64Encoded: keyString) else {
            print("Error: base64 decoding failed")
            throw NSError(domain: "Base64 decoding failed", code: -2, userInfo: nil)
        }
        
        let attributes: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass as String: kSecAttrKeyClassPrivate,
            kSecAttrKeySizeInBits as String: 4096
        ]
        
        var error: Unmanaged<CFError>?
        guard let privateKey = SecKeyCreateWithData(decodedData as CFData, attributes as CFDictionary, &error) else {
            throw error!.takeRetainedValue() as Error
        }
        
        return privateKey
    }

    class func readPublicKey(from path: String) throws -> SecKey? {
        let url = URL(fileURLWithPath: path)
        let keyData = try Data(contentsOf: url)
        guard var keyString = String(data: keyData, encoding: .utf8) else {
            print("Error: Invalid file encoding")
            throw NSError(domain: "Invalid file encoding", code: -1, userInfo: nil)
        }
        
        print(keyString)
        
        keyString = keyString
            .replacingOccurrences(of: "-----BEGIN CERTIFICATE-----", with: "")
            .replacingOccurrences(of: "-----END CERTIFICATE-----", with: "")
            .replacingOccurrences(of: "\n", with: "")
        
        print("Key string after formatted: \(keyString)")

        guard let decodedData = Data(base64Encoded: keyString) else {
            print("Error: base64 decoding failed")
            throw NSError(domain: "Base64 decoding failed", code: -2, userInfo: nil)
        }
        
        print("Decoded data: \(decodedData)")
        
        var error: Unmanaged<CFError>?
        guard let cert = SecCertificateCreateWithData(nil, decodedData as CFData) else {
            print("Can not create cert from data")
            throw error!.takeRetainedValue() as Error
        }
        
        let pubKey = SecCertificateCopyKey(cert)!
        
        return pubKey
    }

    class func encryptJWE(originalData: String, publicKey: SecKey) -> String? {
        do {
            let header = JWEHeader(keyManagementAlgorithm: .RSA1_5, contentEncryptionAlgorithm: .A256GCM)
            
            guard let payloadData = originalData.data(using: .utf8) else {
                throw NSError(domain: "Invalid UTF-8 data", code: -1, userInfo: nil)
            }
            
            let payload = Payload(payloadData)
            
            let encrypter = Encrypter(keyManagementAlgorithm: .RSA1_5, contentEncryptionAlgorithm: .A256GCM, encryptionKey: publicKey)!
     
            guard let jwe = try? JWE(header: header, payload: payload, encrypter: encrypter) else {
                return nil
            }
            
            return jwe.compactSerializedString
        } catch {
            print("Encryption failed: \(error)")
            return nil
        }
    }

    func decryptJWE(jweData: String, privateKey: SecKey) -> String? {
        do {
            let jweObject = try JWE(compactSerialization: jweData)
            
            let decrypter = Decrypter(keyManagementAlgorithm: .RSA1_5, contentEncryptionAlgorithm: .A256GCM, decryptionKey: privateKey)!
            
            let payload = try jweObject.decrypt(using: decrypter)
            
            return String(data: payload.data(), encoding: .utf8)
        } catch {
            print("Error decrypting JWE: \(error)")
            return nil
        }
    }

    class func signerJWS(strData: String, privateKey: SecKey) -> String? {
        do {
            var header = JWSHeader(algorithm: .RS512)
            header.kid = "Napasqrpg2024"
            
            guard let payloadData = strData.data(using: .utf8) else {
                throw NSError(domain: "Invalid UTF-8 data", code: -1, userInfo: nil)
            }
            
            let payload = Payload(payloadData)
            
            let signer = Signer(signatureAlgorithm: .RS512, key: privateKey)!
            
            guard let jws = try? JWS(header: header, payload: payload, signer: signer) else {
                return nil
            }
            
            return jws.compactSerializedString
        } catch {
            print("Signing failed: \(error)")
            return nil
        }
    }

    func verifyJWS(jwsData: String, publicKey: SecKey) -> Bool {
        do {
            let jws = try JWS(compactSerialization: jwsData)
            
            let verifier = Verifier(signatureAlgorithm: .RS512, key: publicKey)!
            
            if jws.isValid(for: verifier) {
                print("JWS verification successful")
                return true
            } else {
                print("JWS verification failed")
                return false
            }
        } catch {
            print("Error parsing or verifying JWS: \(error)")
            return false
        }
    }

    class func genSignature(plainText: String, privateKey: SecKey) throws -> String {
        guard let data = plainText.data(using: .utf8) else {
            throw NSError(domain: "Invalid input encoding", code: 0, userInfo: nil)
        }
        
        let algorithm: SecKeyAlgorithm = .rsaSignatureMessagePSSSHA512
        
        // Ensure the algorithm is supported
        guard SecKeyIsAlgorithmSupported(privateKey, .sign, algorithm) else {
            throw NSError(domain: "Algorithm not supported", code: 0, userInfo: nil)
        }
        
        var error: Unmanaged<CFError>?
        guard let signature = SecKeyCreateSignature(privateKey, algorithm, data as CFData, &error) else {
            throw error!.takeRetainedValue() as Error
        }
        
        return (signature as Data).base64EncodedString()
    }


    class func verifySignature(plainText: String, signature: String, publicKey: SecKey) -> Bool {
        guard let plainTextData = plainText.data(using: .utf8),
            let signatureData = Data(base64Encoded: signature) else {
            return false
        }
        
        var error: Unmanaged<CFError>?
        
        // Verify the signature using SHA512 and RSA
        let isValid = SecKeyVerifySignature(
            publicKey,
            .rsaSignatureMessagePSSSHA512,
            plainTextData as CFData,
            signatureData as CFData,
            &error
        )
        
        if let error = error {
            print("Signature verification error: \(error.takeRetainedValue())")
        }
        
        return isValid
    }

}
