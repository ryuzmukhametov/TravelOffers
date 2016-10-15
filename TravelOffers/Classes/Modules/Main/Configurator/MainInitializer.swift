//
//  MainMainInitializer.swift
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 15/10/2016.
//  Copyright © 2016 ryuzmukhametov. All rights reserved.
//

import UIKit

class MainModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var mainViewController: MainViewController!

    override func awakeFromNib() {

        let configurator = MainModuleConfigurator()
        configurator.configureModuleForViewInput(mainViewController)
    }

}
