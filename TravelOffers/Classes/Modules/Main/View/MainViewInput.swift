//
//  MainMainViewInput.swift
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 15/10/2016.
//  Copyright © 2016 ryuzmukhametov. All rights reserved.
//

protocol MainViewInput: class {

    /**
        @author Rustam Yuzmukhametov
        Setup initial state of the view
    */

    func setupInitialState()    
    func refreshTableWithOffers(offers:[OfferPlainObject])
    func selectSegmentPosition(segmentPosition:Int)
    func showActivityIndicator()
    func showMessage(message:String)
    
}
