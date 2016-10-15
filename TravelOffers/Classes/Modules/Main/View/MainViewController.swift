//
//  MainMainViewController.swift
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 15/10/2016.
//  Copyright © 2016 ryuzmukhametov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewInput, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var activityIndicatory: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var imageLoader:ImageLoader! = nil
    var offers:[OfferPlainObject] = []
    var output: MainViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: MainViewInput
    func setupInitialState() {
    }
    
    func refreshTableWithOffers(offers:[OfferPlainObject]) {
        self.activityIndicatory.hidden = true
        self.tableView.hidden = false
        self.labelMessage.hidden = true
        self.offers = offers
        self.tableView.reloadData()        
    }

    func selectSegmentPosition(segmentPosition:Int) {
        self.segmentControl.selectedSegmentIndex = segmentPosition
    }

    func showActivityIndicator() {
        self.activityIndicatory.hidden = false
        self.activityIndicatory.startAnimating()
        self.tableView.hidden = true
        self.labelMessage.hidden = true
    }
    
    func showMessage(message:String) {
        self.activityIndicatory.hidden = true
        self.tableView.hidden = true
        self.labelMessage.hidden = false
        self.labelMessage.text = message
    }

    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! OfferTableViewCell
        let offer = self.offers[indexPath.row]
        cell.timeLabel.text = "\(offer.departureTime) - \(offer.arrivalTime)"
        cell.durationLabel.text = offer.duration
        cell.priceLabel.text = "€" + String(format:"%0.2lf", offer.priceInEuros.doubleValue)

        if offer.providerLogo.isEmpty {
            cell.imageViewLogo.image = nil
        } else {
            let urlStr : NSString = offer.providerLogo.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            let url = NSURL(string: urlStr as String)
            let image = self.imageLoader.loadedImageByURL(url)
            cell.imageViewLogo.image = image
            
            
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let offer = self.offers[indexPath.row]
        let urlStr : NSString = offer.providerLogo.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let url = NSURL(string: urlStr as String)
        
        self.imageLoader.loadImageByURL(url) { (image, error) in
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alertControll = UIAlertController(title: "Message", message: "Offer details are not yet implemented!", preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) in
            alertControll.dismissViewControllerAnimated(true, completion: nil)
        }
        alertControll.addAction(alertAction)
        
        self.presentViewController(alertControll, animated: true, completion: nil)
    }
    

    // MARK: IBActions
    @IBAction func segmentValueChanged(sender: AnyObject) {
        self.output.didSelectSegmentWithPosition(self.segmentControl.selectedSegmentIndex)
    }
    
}
