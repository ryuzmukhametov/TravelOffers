//
//  MainMainConfigurator.swift
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 15/10/2016.
//  Copyright © 2016 ryuzmukhametov. All rights reserved.
//

import UIKit

class MainModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? MainViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: MainViewController) {

        let router = MainRouter()

        let presenter = MainPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = MainInteractor()
        interactor.offerPersistenceService = AssembliesLinker.sharedInstance.serviceComponentsAssembly.offerPersistenceService
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
