//
//  ListTableViewController.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit


class ListTableViewController: UITableViewController {
    
    let kCityTableViewCellReuseIdentifier = "CityTableViewCellReuseIdentifier"

    
    // MARK: - VIPER Properties
    var presenter: ListPresenterProtocol!

    var cities: [City] = []
    var citiesFromPersistentStore: [City] = []

    
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
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.rightBarButtonItems!.append(self.editButtonItem())
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter.getCities()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return citiesFromPersistentStore.count
        case 1:
            return cities.count
        default:
            fatalError("Wrong section")
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return self.tableView(tableView, numberOfRowsInSection: section) == 0 ? nil : "From persistent store"
        case 1:
            return self.tableView(tableView, numberOfRowsInSection: section) == 0 ? nil : "Local"
        default:
            fatalError("Wrong section")
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(kCityTableViewCellReuseIdentifier, forIndexPath: indexPath) as! CityTableViewCell
            cell.city = citiesFromPersistentStore[indexPath.row]
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(kCityTableViewCellReuseIdentifier, forIndexPath: indexPath) as! CityTableViewCell
            cell.city = cities[indexPath.row]
            return cell
            
        default:
            fatalError("Wrong indexPath")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            let city = citiesFromPersistentStore[indexPath.row]
            self.presenter.showDetailCity(city)

        case 1:
            let city = cities[indexPath.row]
            self.presenter.showDetailCity(city)

        default:
            fatalError("Wrong section")
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            switch indexPath.section {
            case 0:
                let city = citiesFromPersistentStore[indexPath.row]
                self.presenter.removeCity(city)
            case 1:
                cities.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            default:
                fatalError("Wrong section")
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    @IBAction func add(sender: AnyObject) {
        self.presenter.addNew()
    }
    
    @IBAction func exit(sender: AnyObject) {
        self.presenter.exit()
    }    
}

extension ListTableViewController: ListInterfaceProtocol {
    
    func showCities(cities: [City]) {
        citiesFromPersistentStore = cities
        self.tableView.reloadData()
    }
}

extension ListTableViewController: AddViewControllerDelegate {
    
    func addViewControllerDidSelectCity(city: City) {
        cities.append(city)
        self.tableView.reloadData()
    }
}
