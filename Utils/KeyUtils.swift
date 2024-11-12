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
        
        // Remove PEM headers and newlines
        keyString = keyString
            .replacingOccurrences(of: "-----BEGIN RSA PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "-----END RSA PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "\n", with: "")
        
        guard let decodedData = Data(base64Encoded: keyString) else {
            print("Error: base64 decoding failed")
            throw NSError(domain: "Base64 decoding failed", code: -2, userInfo: nil)
        }
        
        // Define attributes for the key
        let attributes: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass as String: kSecAttrKeyClassPrivate,
            kSecAttrKeySizeInBits as String: 4096
        ]
        
        // Create the key using the Security framework
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
        
        // Remove PEM headers and newlines
        keyString = keyString
            .replacingOccurrences(of: "-----BEGIN CERTIFICATE-----", with: "")
            .replacingOccurrences(of: "-----END CERTIFICATE-----", with: "")
            .replacingOccurrences(of: "\n", with: "")
            // .split(separator: "\n").joined()
        
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
            // Set up JWE Header with the appropriate algorithm and encryption method
            let header = JWEHeader(keyManagementAlgorithm: .RSA1_5, contentEncryptionAlgorithm: .A256GCM)
            
            // Convert the original data to Data format
            guard let payloadData = originalData.data(using: .utf8) else {
                throw NSError(domain: "Invalid UTF-8 data", code: -1, userInfo: nil)
            }
            
            // Create a JWE object with the header and payload
            let payload = Payload(payloadData)
            
            // Encrypt the payload with the RSA public key and the generated CEK
            let encrypter = Encrypter(keyManagementAlgorithm: .RSA1_5, contentEncryptionAlgorithm: .A256GCM, encryptionKey: publicKey)!
     
            guard let jwe = try? JWE(header: header, payload: payload, encrypter: encrypter) else {
                return nil
            }
            
            // Serialize the JWE object to a compact string representation
            return jwe.compactSerializedString
        } catch {
            print("Encryption failed: \(error)")
            return nil
        }
    }

    class func signerJWS(strData: String, privateKey: SecKey) -> String? {
        do {
            // Set up JWS Header with the RS512 algorithm and key ID
            var header = JWSHeader(algorithm: .RS512)
            header.kid = "Napasqrpg2024"
            
            // Convert the data to Data format
            guard let payloadData = strData.data(using: .utf8) else {
                throw NSError(domain: "Invalid UTF-8 data", code: -1, userInfo: nil)
            }
            
            // Create a JWS object with the header and payload
            let payload = Payload(payloadData)
            
            // Sign the JWS using the private key
            let signer = Signer(signatureAlgorithm: .RS512, key: privateKey)!
            
            guard let jws = try? JWS(header: header, payload: payload, signer: signer) else {
                return nil
            }
            
            // Serialize the JWS object to a compact string representation
            return jws.compactSerializedString
        } catch {
            print("Signing failed: \(error)")
            return nil
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

    class func loadPublicKey(from filePath: String) -> SecKey? {
        do {
            // Load the .pem file contents as a string
            let pemString = try String(contentsOfFile: filePath, encoding: .utf8)
            
            // Remove the header and footer
            let keyString = pemString
                .replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----", with: "")
                .replacingOccurrences(of: "-----END PUBLIC KEY-----", with: "")
                .replacingOccurrences(of: "\n", with: "")
            
            // Decode the Base64 string to raw key data
            guard let keyData = Data(base64Encoded: keyString) else {
                print("Failed to decode base64")
                return nil
            }
            
            // Define attributes for a public key
            let attributes: [String: Any] = [
                kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                kSecAttrKeyClass as String: kSecAttrKeyClassPublic,
                kSecAttrKeySizeInBits as String: 2048
            ]
            
            // Create a SecKey instance from the raw key data
            guard let publicKey = SecKeyCreateWithData(keyData as CFData, attributes as CFDictionary, nil) else {
                print("Failed to create public key")
                return nil
            }
            
            return publicKey
        } catch {
            print("Error reading .pem file: \(error)")
            return nil
        }
    }
}
