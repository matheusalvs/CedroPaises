//
//  RestApiManager.swift
//  Cedro Paises
//
//  Created by Matheus Alves on 02/03/17.
//  Copyright © 2017 Matheus Alves. All rights reserved.
//

import Foundation
import SwiftyJSON

class RestApiManager: NSObject {
    
    let config = URLSessionConfiguration.default
    let url = "http://sslapidev.mypush.com.br/"
    
     func getAllCountries( completion: @escaping ([Country]) -> Void) {
        var countries = [Country]()
        self.makeHttpRequest(path: "world/countries/active") { jsonString in
            countries = Country.parseJson(jsonString: jsonString)
            completion(countries)
        }
    }
    
    func makeHttpRequest(path: String, completion: @escaping (String) -> ()) {
        if let url = URL(string: self.url + path) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                data, response, error in
                if let data = data, let jsonString = String(data: data, encoding: String.Encoding.utf8), error == nil {
                    completion(jsonString)
                } else {
                    print("error=\(error!.localizedDescription)")
                }
            }
            task.resume()
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
