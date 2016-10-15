//
//  MainMainInteractorInput.swift
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 15/10/2016.
//  Copyright © 2016 ryuzmukhametov. All rights reserved.
//

import Foundation

protocol MainInteractorInput {

    func readTrainOffers() -> [OfferPlainObject]
    func readBusOffers() -> [OfferPlainObject]
    func readFlightOffers() -> [OfferPlainObject]
    
    func refreshTrainOffers()
    func refreshBusOffers()
    func refreshFlightOffers()
    
}
