//
//  NetworkManager.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 07/02/21.
//

import UIKit
import Alamofire

final class NetworkManager<T: Codable> {
    static func fetch(from urlString: String, completion: @escaping ((Result<T, TaskError>)) -> ()) {
        AF.request(urlString).responseDecodable(of: T.self) { (resp) in
            if(resp.error != nil) {
                completion(.failure(.invalidResponse))
                print(resp.error!)
                return
            }
            
            if let payload = resp.value {
                completion(.success(payload))
            }
            completion(.failure(.nilResponse))
        }
    }
}


enum TaskError: Error {
    case invalidResponse
    case nilResponse
}
