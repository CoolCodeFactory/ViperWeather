//
//  ListTableViewController.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftFetchedResultsController


class ListTableViewController: UITableViewController {
    
    let kCityWeatherTableViewCellReuseIdentifier = "CityWeatherTableViewCellReuseIdentifier"

    
    // MARK: - VIPER Properties
    var presenter: ListPresenterProtocol!


    var cityFetchedResultsController: FetchedResultsController<CityEntity>!
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
        let realm = try! Realm()
        let predicate = NSPredicate(format: "placeID != %@", "0")
        let fetchRequest = FetchRequest<CityEntity>(realm: realm, predicate: predicate)
        let sortDescriptor = SortDescriptor(property: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        self.cityFetchedResultsController = FetchedResultsController<CityEntity>(fetchRequest: fetchRequest, sectionNameKeyPath: nil, cacheName: nil)
        self.cityFetchedResultsController!.delegate = self
        self.cityFetchedResultsController!.performFetch()
        
        super.viewDidLoad()

        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.registerNib(UINib(nibName: "CityWeatherTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: kCityWeatherTableViewCellReuseIdentifier)
        
        navigationItem.rightBarButtonItems!.append(self.editButtonItem())
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter.updateWeather()
        
        if let indexPathForSelectedRow = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(indexPathForSelectedRow, animated: animated)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cityFetchedResultsController.numberOfRowsForSectionIndex(section)
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
            let cell = tableView.dequeueReusableCellWithIdentifier(kCityWeatherTableViewCellReuseIdentifier, forIndexPath: indexPath) as! CityWeatherTableViewCell
            if let cityEntity = cityFetchedResultsController.objectAtIndexPath(indexPath) {
                let currentWeather: Weather?
                if let weather = cityEntity.currentWeather {
                    currentWeather = Weather(dt: weather.dt, temp: weather.temp, pressure: weather.pressure, icon: weather.icon)
                } else {
                    currentWeather = nil
                }
                let city = City(title: cityEntity.title, placeID: cityEntity.placeID, currentWeather: currentWeather, lat: cityEntity.lat, lng: cityEntity.lng)
                cell.city = city
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(kCityWeatherTableViewCellReuseIdentifier, forIndexPath: indexPath) as! CityWeatherTableViewCell
            cell.city = cities[indexPath.row]
            return cell
            
        default:
            fatalError("Wrong indexPath")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            if let cityEntity = cityFetchedResultsController.objectAtIndexPath(indexPath) {
                let currentWeather: Weather?
                if let weather = cityEntity.currentWeather {
                    currentWeather = Weather(dt: weather.dt, temp: weather.temp, pressure: weather.pressure, icon: weather.icon)
                } else {
                    currentWeather = nil
                }
                let city = City(title: cityEntity.title, placeID: cityEntity.placeID, currentWeather: currentWeather, lat: cityEntity.lat, lng: cityEntity.lng)
                self.presenter.showDetailCity(city)
            }

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
                if let cityEntity = cityFetchedResultsController.objectAtIndexPath(indexPath) {
                    let currentWeather: Weather?
                    if let weather = cityEntity.currentWeather {
                        currentWeather = Weather(dt: weather.dt, temp: weather.temp, pressure: weather.pressure, icon: weather.icon)
                    } else {
                        currentWeather = nil
                    }
                    let city = City(title: cityEntity.title, placeID: cityEntity.placeID, currentWeather: currentWeather, lat: cityEntity.lat, lng: cityEntity.lng)
                    self.presenter.removeCity(city)
                }
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
        return false
    }

    @IBAction func add(sender: AnyObject) {
        self.presenter.addNew()
    }
    
    @IBAction func exit(sender: AnyObject) {
        self.presenter.exit()
    }    
}

extension ListTableViewController: ListInterfaceProtocol {
    
    func showWeatherForCity(weather: Weather?, city: City) {
        // ...
    }
}

extension ListTableViewController: AddViewControllerDelegate {
    
    func addViewControllerDidSelectCity(city: City) {
        cities.append(city)
        self.tableView.reloadData()
    }
}

extension ListTableViewController: FetchedResultsControllerDelegate {
    
    func controllerWillChangeContent<T : Object>(controller: FetchedResultsController<T>) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeObject<T : Object>(controller: FetchedResultsController<T>, anObject: SafeObject<T>, indexPath: NSIndexPath?, changeType: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        let tableView = self.tableView
        
        switch changeType {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.None)
            
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    func controllerDidChangeSection<T : Object>(controller: FetchedResultsController<T>, section: FetchResultsSectionInfo<T>, sectionIndex: UInt, changeType: NSFetchedResultsChangeType) {
        let tableView = self.tableView
        
        if changeType == NSFetchedResultsChangeType.Insert {
            let indexSet = NSIndexSet(index: Int(sectionIndex))
            tableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.Fade)
            // tableView.insertSections(indexSet, withRowAnimation: UITableViewRowAnimation.Fade)
        }
        else if changeType == NSFetchedResultsChangeType.Delete {
            let indexSet = NSIndexSet(index: Int(sectionIndex))
            tableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.Fade)
            // tableView.deleteSections(indexSet, withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }

    func controllerDidChangeContent<T : Object>(controller: FetchedResultsController<T>) {
        self.tableView.endUpdates()
    }
}
