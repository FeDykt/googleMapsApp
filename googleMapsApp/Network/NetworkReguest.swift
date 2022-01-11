//
//  NetworkReguest.swift
//  googleMapsApp
//
//  Created by fedot on 10.01.2022.
//

import Foundation

protocol Networking {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}


class NetworkService: Networking {

    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = dataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func dataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}
