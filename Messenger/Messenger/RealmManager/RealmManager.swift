//
//  RealmManager.swift
//  Messenger
//
//  Created by Polly on 08.08.2022.
//

import Foundation
import RealmSwift


class RealmManager {
    
    static let shared = RealmManager()
    
    private let realm: Realm
    
    private init?() {
        let configurator = Realm.Configuration(schemaVersion: 1,  deleteRealmIfMigrationNeeded: true)
        
        guard let realm = try? Realm(configuration: configurator) else { return nil}
        self.realm = realm
        
        
        print(realm.configuration.fileURL ?? "")
    }
    
    func add<T: Object>(object: T) throws {
        try realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func add<T: Object>(objects: [T]) throws {
        try realm.write {
            realm.add(objects, update: .all)
        }
    }
    
    func getObjects<T: Object>() -> Results<T> {
        return realm.objects(T.self)
    }

    
    func delete<T: Object>(object: T) throws {
        try realm.write {
            realm.delete(object)
        }
    }
    
    
    func deleteAll() throws {
        try realm.write {
            realm.deleteAll()
        }
    }
    
}



