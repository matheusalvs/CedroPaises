//
//  Country.swift
//  Cedro Paises
//
//  Created by Matheus Alves on 06/03/17.
//  Copyright © 2017 Matheus Alves. All rights reserved.
//

import UIKit
import RealmSwift

class Country: Object {
    
    dynamic var id: Int = 0
    dynamic var iso: String = ""
    dynamic var shortName: String = ""
    dynamic var longName: String = ""
    dynamic var callingCode: String = ""
    dynamic var status: Int = 0
    dynamic var culture: String = ""
    dynamic var image: String = ""
    dynamic var visitedDate: NSDate? = nil
    
    static func parseJson(jsonString:String) -> Array<Country>{
        
        let data: NSData = jsonString.data(using: String.Encoding.utf8)! as NSData
        
        let anyObj: AnyObject? = try! JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions()) as AnyObject?
        
        var list:Array<Country> = []
        
        if  anyObj is Array<AnyObject> {
            var i = 1
            for json in anyObj as! Array<AnyObject>{
                let x: Country = Country()
                x.id = (json["id"] as AnyObject? as? Int) ?? 0
                x.iso  =  (json["iso"]  as AnyObject? as? String) ?? ""
                x.shortName  =  (json["shortname"]  as AnyObject? as? String) ?? ""
                x.longName  =  (json["longname"]  as AnyObject? as? String) ?? ""
                x.callingCode  =  (json["callingCode"]  as AnyObject? as? String) ?? ""
                x.status  =  (json["status"]  as AnyObject? as? Int) ?? 0
                x.culture  =  (json["culture"]  as AnyObject? as? String) ?? ""
                x.image = ImageUtils.getImageByUrl(url: "http://sslapidev.mypush.com.br/world/countries/" + String(x.id) + "/flag")
                
                
                list.append(x)
                print(i)
                i += 1
            }
            
        }
        
        return list
        
    }

    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func insert(country: Country) {
        let realm = try! Realm()
        try! realm.write(){
            realm.add(country)
        }
    }
    
    static func insertList(countries: [Country]) {
        let realm = try! Realm()
        if countries.count > 0 {
            try! realm.write(){
                for country in countries {
                    realm.add(country)
                }
            }
            
        }
    }
    
    static func findAll() -> [Country] {
        let realm = try! Realm()
        return Array(realm.objects(Country.self).sorted(byKeyPath: "shortName"))
    }
    
    static func findAllVisited() -> [Country] {
        let realm = try! Realm()
        return Array(realm.objects(Country.self).filter("visitedDate != nil").sorted(byKeyPath: "shortName"))
    }
    
    static func update(country: Country){
        let realm = try! Realm()
        try! realm.write(){
            realm.add(country, update: true)
        }
    }
    
    static func deleteAll(){
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
