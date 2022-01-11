//
//  NetworkDecode.swift
//  googleMapsApp
//
//  Created by fedot on 10.01.2022.
//

import Foundation

class NetworkDecode {
    var request: DataFetcher

    init(reguest: DataFetcher = NetworkDataFetcher()) {
        self.request = reguest
    }
    
    func getDecode(completion: @escaping (Result<MapsModel?, Error>) -> Void) {
        let url = "http://a0532495.xsph.ru/getPoint"
        request.fetchGenericJSONData(urlString: url, completion: completion)
    }
    
    func direction(from: String, to: String, completion: @escaping (Result<MapsModel?, Error>) -> Void) {
        let key = "AIzaSyA61CvoMcnd2A9RA2xuauYTkOeFOur1ZQs"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(to)&destination=\(from)&key=\(key)"
        request.fetchGenericJSONData(urlString: url, completion: completion)
    }
}
