//
//  Presenter.swift
//  CryptoViper
//
//  Created by Eren Elçi on 30.10.2024.
//

import Foundation
//Class protocol
//talks to -> interactor , router , view

enum NetworkError : Error {
    case NetworkFaild
    case ParsingFailed
}

protocol AnyPresenter {
    var router : AnyRouter? { get set }
    var interactor : AnyInteractor? { get set }
    var view : AnyView? { get set }
    
    func interactorDidDowlandCrypto(result: Result<[Crypto],Error>)
}

class CryptoPresenter: AnyPresenter {
    var router: (any AnyRouter)?
    
    var interactor: (any AnyInteractor)? {
        didSet {
            interactor?.downloadCyroptos()
        }
    }
    
    var view: (any AnyView)?
    
    func interactorDidDowlandCrypto(result: Result<[Crypto], any Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure( _ ):
            view?.update(with: "Try again Lettter")
            
        }
    }
    
    
    
    
    
    
}
