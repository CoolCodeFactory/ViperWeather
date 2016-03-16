//
//  AddTableViewController.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit


class AddTableViewController: UITableViewController {
    
    let kCityTableViewCellReuseIdentifier = "CityTableViewCellReuseIdentifier"
    
    
    // MARK: VIPER Properties
    var presenter: AddPresenterProtocol!

    let searchController = UISearchController(searchResultsController: nil)

    var cities: [City] = []
    
    
    override var nibName: String? {
        get {
            let classString = String(self.dynamicType)
            return classString
        }
    }
    override var nibBundle: NSBundle? {
        get {
            return NSBundle.mainBundle()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "CityTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: kCityTableViewCellReuseIdentifier)

        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        tableView.tableHeaderView = searchController.searchBar

        definesPresentationContext = true

        searchController.searchBar.sizeToFit()

        searchController.active = true
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCityTableViewCellReuseIdentifier, forIndexPath: indexPath) as! CityTableViewCell
        cell.city = cities[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let city = cities[indexPath.row]
        
        let alertController = UIAlertController(title: city.title, message: "Save to storage and Add to list or Add only", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveAction =  UIAlertAction(title: "Save to storage", style: UIAlertActionStyle.Default) { [weak self] (action) -> Void in
            self?.presenter.selectAndSaveCity(city)
        }
        alertController.addAction(saveAction)
        
        let addAction = UIAlertAction(title: "Add only", style: UIAlertActionStyle.Default) { [weak self] (action) -> Void in
            self?.presenter.selectCity(city)
        }
        alertController.addAction(addAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func cancel(sender: AnyObject) {
        self.presenter.cancel()
    }
}

extension AddTableViewController: AddInterfaceProtocol {
    
    func showEmpty() {
        self.cities.removeAll()
        self.tableView.reloadData()
    }
    
    func showCities(cities: [City]) {
        self.cities.removeAll()
        self.cities = cities
        self.tableView.reloadData()
    }
}

extension AddTableViewController: UISearchControllerDelegate {
    
    func didPresentSearchController(searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}

extension AddTableViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.presenter.cancel()
    }
}

extension AddTableViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.presenter.getCitiesWithName(searchController.searchBar.text!)
    }
}
