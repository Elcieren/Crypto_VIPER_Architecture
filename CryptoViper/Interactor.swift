//
//  Interactor.swift
//  CryptoViper
//
//  Created by Eren Elçi on 30.10.2024.
//

import Foundation
// Class protocol
// talks to -> presenter

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set}
    func downloadCyroptos()
}

class CryptoInteractor : AnyInteractor {
    var presenter: (any AnyPresenter)?
    
    func downloadCyroptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data , respons , error) in
            guard let data = data , error == nil else {
                self.presenter?.interactorDidDowlandCrypto(result: .failure(NetworkError.NetworkFaild))
                return
            }
            do {
                let cryptos =  try JSONDecoder().decode([Crypto].self, from: data)
                self.presenter?.interactorDidDowlandCrypto(result: .success(cryptos))
            } catch {
                self.presenter?.interactorDidDowlandCrypto(result: .failure(NetworkError.ParsingFailed))
            }
        }
        task.resume()
    }
    
    
}
