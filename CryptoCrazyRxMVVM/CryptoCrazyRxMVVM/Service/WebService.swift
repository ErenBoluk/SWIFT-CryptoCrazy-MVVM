//
//  File.swift
//  CryptoCrazyRxMVVM
//
//  Created by midDeveloper on 26.08.2023.
//

import Foundation
enum CryptoError : Error {
    case serverError
    case parseError
}

class WebService  {
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto], CryptoError>) -> () )  {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.serverError))
            }else if let data = data {
                
                    let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                    
                    if let cryptoList = cryptoList {
                        completion(.success(cryptoList))
                    }else{
                        completion(.failure(.parseError))
                    }
            }
            
            
        }
    }
}
