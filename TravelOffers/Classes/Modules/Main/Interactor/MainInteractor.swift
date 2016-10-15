//
//  MainMainInteractor.swift
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 15/10/2016.
//  Copyright © 2016 ryuzmukhametov. All rights reserved.
//



class MainInteractor: MainInteractorInput {

    weak var output: MainInteractorOutput!
    
    var offerPersistenceService:OfferPersistenceService! = nil
    
    func readBusOffers() -> [OfferPlainObject] {
        return offerPersistenceService.fetchBusOffers()
    }
    
    func refreshBusOffers() {
        offerPersistenceService.refreshBusOffers()
    }

}
