//
//  MainMainConfiguratorTests.swift
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 15/10/2016.
//  Copyright © 2016 ryuzmukhametov. All rights reserved.
//

import XCTest

class MainModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = MainViewControllerMock()
        let configurator = MainModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewController)

        //then
        XCTAssertNotNil(viewController.output, "MainViewController is nil after configuration")
        XCTAssertTrue(viewController.output is MainPresenter, "output is not MainPresenter")

        let presenter: MainPresenter = viewController.output as! MainPresenter
        XCTAssertNotNil(presenter.view, "view in MainPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in MainPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is MainRouter, "router is not MainRouter")

        let interactor: MainInteractor = presenter.interactor as! MainInteractor
        XCTAssertNotNil(interactor.output, "output in MainInteractor is nil after configuration")
    }

    class MainViewControllerMock: MainViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
