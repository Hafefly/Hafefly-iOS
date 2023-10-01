//
//  UserDefaults.swift
//  Hafefly
//
//  Created by Samy Mehdid on 30/9/2023.
//

import Foundation

public protocol ObjectSaveable {
    func setObject<Object>(_ object: Object, forKey key: String) where Object: Encodable
    func getObject<Object>(forKey: String, fallback: ()->Object) -> Object where Object: Decodable
}


extension UserDefaults: ObjectSaveable {
    public func setObject<Object>(_ object: Object, forKey key: String) where Object: Encodable {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(object) {
            set(data, forKey: key)
        } else {
            print("Could not store object with key(\(key) in the user defaults")
        }
    }
    
    public func getObject<Object>(forKey: String, fallback: ()->Object) -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { return fallback() }
        let decoder = JSONDecoder()
        
        do {
            let object = try decoder.decode(Object.self, from: data)
            return object
        } catch {
            print("Catched \(error) while parse object from user defaults")
            return fallback()
        }
    }
    
    public func getObject<Object>(forKey: String) -> Object? where Object: Decodable {
        guard let data = data(forKey: forKey) else { return nil }
        let decoder = JSONDecoder()
        
        do {
            let object = try decoder.decode(Object.self, from: data)
            return object
        } catch {
            print("Catched \(error) while parse object from user defaults")
            return nil
        }
    }
    
    dynamic var userData: HFUser? {
        get { getObject(forKey: "user_data") }
        set { setObject(newValue, forKey: "user_data") }
    }
    
    public func clearSession() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            if key != "fcmToken" {
                defaults.removeObject(forKey: key)
            }
        }
    }
}

