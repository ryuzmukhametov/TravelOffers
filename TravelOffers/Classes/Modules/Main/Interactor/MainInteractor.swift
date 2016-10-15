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
    
    // NOTE: MainInteractorInput
    func readTrainOffers() -> [OfferPlainObject] {
        return offerPersistenceService.fetchTrainOffers()
    }
    
    func readBusOffers() -> [OfferPlainObject] {
        return offerPersistenceService.fetchBusOffers()
    }
    
    func readFlightOffers() -> [OfferPlainObject] {
        return offerPersistenceService.fetchFlightOffers()
    }
    
    func refreshTrainOffers() {
        offerPersistenceService.refreshTrainOffersWithCompletionBlock { (error) in
            self.output.didRefreshTrainOffersWithError(error)
        }
    }
    
    func refreshBusOffers() {
        offerPersistenceService.refreshBusOffersWithCompletionBlock { (error) in
            self.output.didRefreshBusOffersWithError(error)
        }
    }
    
    func refreshFlightOffers() {
        offerPersistenceService.refreshFlightOffersWithCompletionBlock { (error) in
            self.output.didRefreshFlightOffersWithError(error)
        }
    }

    
    

}
