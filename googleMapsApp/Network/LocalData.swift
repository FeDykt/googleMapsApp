//
//  LocalData.swift
//  googleMapsApp
//
//  Created by fedot on 10.01.2022.
//

import Foundation

class LocalDataFetcher: NetworkDataFetcher {
    
    func fetchGenericJSONData<T>(urlString: String, completion: @escaping (T?) -> Void) where T : Decodable {
        
        guard let file = Bundle.main.url(forResource: urlString, withExtension: nil) else {
            print("Couldn't find \(urlString) in main bundle.")
            completion(nil)
            return
        }
        
        let data = try? Data(contentsOf: file)
        
        let decoded = self.decodeJSON(type: T.self, from: data)
        completion(decoded)
    }
    
}
