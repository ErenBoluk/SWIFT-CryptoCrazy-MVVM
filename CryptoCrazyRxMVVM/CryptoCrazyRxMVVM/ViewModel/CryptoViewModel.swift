//
//  CryptoViewModel.swift
//  CryptoCrazyRxMVVM
//
//  Created by midDeveloper on 26.08.2023.
//

import Foundation
import RxSwift
import RxCocoa

class  CryptoViewModel  {
    
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject()
    
    func requestData()  {
        
        self.loading.onNext(true)
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/2be0f55346f62e545f2cc97aa8e28666aa672974/crypto.json")!
        
        WebService().downloadCurrencies(url: url) { result in
            self.loading.onNext(false)
            switch result {
                case .success(let cryptos):
                self.cryptos.onNext(cryptos)
                case .failure(let error):
                    switch error{
                        case .parseError:
                            self.error.onNext("Parse Error")
                        case .serverError:
                            self.error.onNext("Server Error")
                    }
            }
        }
    }
}
