//
//  AssembliesLinker.swift
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

import Foundation

class AssembliesLinker : NSObject {
    
    static let sharedInstance = AssembliesLinker()
    
    var networkClientAssembly:NetworkClientsAssembly! = nil
    var serviceComponentsAssembly:ServiceComponentsAssembly! = nil
    
    override init() {
        super.init()
        self.networkClientAssembly = self.buildNetworkClinetAssembly()
        self.serviceComponentsAssembly = self.buildServiceComponentsAssembly()
    }
    
    
    func buildNetworkClinetAssembly() -> NetworkClientsAssembly {
        let networkClientAssembly = NetworkClientsAssembly()
        networkClientAssembly.commonNetworkClient = NetworkClientImplementation()
        return networkClientAssembly
    }
    
    func buildServiceComponentsAssembly() -> ServiceComponentsAssembly {
        let serviceComponentsAssembly = ServiceComponentsAssembly()
        let offerNetworkService:OfferNetworkServiceImplementation = OfferNetworkServiceImplementation()
        offerNetworkService.networkClient = networkClientAssembly.commonNetworkClient
        let offerPersistenceService:OfferPersistenceServiceImplementation = OfferPersistenceServiceImplementation()
        offerPersistenceService.offerNetworkService = offerNetworkService
        serviceComponentsAssembly.offerPersistenceService = offerPersistenceService
        return serviceComponentsAssembly
    }
    
    
}
