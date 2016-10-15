//
//  MainMainPresenter.swift
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 15/10/2016.
//  Copyright © 2016 ryuzmukhametov. All rights reserved.
//

class MainPresenter: MainModuleInput, MainViewOutput, MainInteractorOutput {

    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!
    
    var selectedPosition:Int = 0

    // MARK: MainViewOutput
    func viewIsReady() {
        //interactor.refreshBusOffers()
        let trainOffers = interactor.readTrainOffers()
        view.selectSegmentPosition(0)
        if trainOffers.count > 0 {
            self.callRefreshViewWithOffers(trainOffers)
        } else {
            view.showActivityIndicator()
        }
        interactor.refreshTrainOffers()
    }

    func didSelectSegmentWithPosition(position:Int) {
        self.selectedPosition = position
        let offers:[OfferPlainObject]
        if (position == 0) {
            offers = interactor.readTrainOffers()
            interactor.refreshTrainOffers()
        } else if (position == 1) {
            offers = interactor.readBusOffers()
            interactor.refreshBusOffers()
        } else {
            offers = interactor.readFlightOffers()
            interactor.refreshFlightOffers()
        }
        
        if offers.count > 0 {
            self.callRefreshViewWithOffers(offers)
        } else {
            view.showActivityIndicator()
        }
    }


    // NOTE: MainInteractorOutput
    func didRefreshTrainOffersWithError(error:NSError?) {
        if self.selectedPosition != 0 {
            return
        }
        if !processError(error) {
            processOffers(interactor.readTrainOffers())
        }
    }
    
    func didRefreshBusOffersWithError(error:NSError?) {
        if self.selectedPosition != 1 {
            return
        }
        if !processError(error) {
            processOffers(interactor.readBusOffers())
        }
    }
    
    
    func didRefreshFlightOffersWithError(error:NSError?) {
        if self.selectedPosition != 2 {
            return
        }
        if !processError(error) {
            processOffers(interactor.readFlightOffers())
        }
    }
    
    // NOTE: Private    
    func processError(error:NSError?) -> Bool {
        if error != nil {
            view.showMessage("Data loading error")
            return true
        } else {
            return false
        }
    }
    
    func processOffers(offers:[OfferPlainObject]) {
        if offers.count > 0 {
            callRefreshViewWithOffers(offers)
        } else {
            view.showMessage("Result is empty")
        }
    }
    
    func differnceBetweenStartTimeStr(startTimeStr:String, endTimeStr:String) -> String {
        let startTimeInMinutes = convertTimeStrToMinutes(startTimeStr)
        let endTimeInMinutes = convertTimeStrToMinutes(endTimeStr)
        let diffInMinutes:Int
        if (endTimeInMinutes > startTimeInMinutes) {
            diffInMinutes =  endTimeInMinutes - startTimeInMinutes
        } else {
            diffInMinutes = endTimeInMinutes - startTimeInMinutes + 24 * 60
        }
        let hours = diffInMinutes / 60
        let minutes = diffInMinutes % 60
        return "\(hours):" + String(format: "%02d", minutes)
    }
    
    func convertTimeStrToMinutes(timeStr:String) -> Int {
        let components = timeStr.componentsSeparatedByString(":")
        let hours = Int(components[0])!
        let minutes = Int(components[1])!
        return hours * 60 + minutes
    }
    
    func calculateDurationForOffers(offers:[OfferPlainObject]) {
        for offer in offers {
            let dif = differnceBetweenStartTimeStr(offer.departureTime, endTimeStr: offer.arrivalTime)
            if offer.numberOfStops == 0 {
                offer.duration = "Direct  \(dif)h"
            } else if offer.numberOfStops == 1 {
                offer.duration = "\(offer.numberOfStops) change  \(dif)h"
            } else {
                offer.duration = "\(offer.numberOfStops) changes  \(dif)h"
            }
        }
    }
    
    func replacePlaceholderSizeInOffers(offers:[OfferPlainObject]) {
        for offer in offers {
            offer.providerLogo = offer.providerLogo.stringByReplacingOccurrencesOfString("{size}", withString: "63")
            print("logo = \(offer.providerLogo)")
        }
    }
    
    func callRefreshViewWithOffers(offers:[OfferPlainObject]) {
        replacePlaceholderSizeInOffers(offers)
        calculateDurationForOffers(offers)
        view.refreshTableWithOffers(offers)
    }

}
