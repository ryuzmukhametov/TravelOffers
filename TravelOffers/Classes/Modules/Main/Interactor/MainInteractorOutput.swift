//
//  MainMainInteractorOutput.swift
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 15/10/2016.
//  Copyright © 2016 ryuzmukhametov. All rights reserved.
//

import Foundation

protocol MainInteractorOutput: class {

    func didRefreshTrainOffersWithError(error:NSError?)
    func didRefreshBusOffersWithError(error:NSError?)
    func didRefreshFlightOffersWithError(error:NSError?)
}
