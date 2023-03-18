//
//  KeychainManager.swift
//  Hafefly
//
//  Created by Samy Mehdid on 16/3/2023.
//

import Foundation

final class KeychainHelper {
    
    static let standard = KeychainHelper()
    
    private init() {}
    
    func save(_ data: Data, key: String) {
        
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: key,
            kSecAttrAccount: "hafefly",
        ] as CFDictionary
        
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            // Item already exist, thus update it.
            let query = [
                kSecAttrService: key,
                kSecAttrAccount: "hafefly",
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            // Update existing item
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    
    func read(_ key: String) -> Data? {
        
        let query = [
            kSecAttrService: key,
            kSecAttrAccount: "hafefly",
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    func delete(_ key: String) {
        
        let query = [
            kSecAttrService: key,
            kSecAttrAccount: "hafefly",
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
    
    func save<T>(_ item: T, key: String) where T : Codable {
        
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            save(data, key: key)
            
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }
    
    func read<T>(key: String, type: T.Type) -> T? where T : Codable {
        
        // Read item data from keychain
        guard let data = read(key) else {
            return nil
        }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
    // MARK: - extension
    @objc dynamic var accessToken: String? {
        get { self.read(key: "access-token", type: String.self) }
        set { self.save(newValue, key: "access-token") }
    }
    
    @objc dynamic var refreshToken: String? {
        get { self.read(key: "refresh-token", type: String.self) }
        set { self.save(newValue, key: "refresh-token") }
    }
    
    func clearSession() {
        self.delete("access-token")
        self.delete("refresh-token")
    }
}
