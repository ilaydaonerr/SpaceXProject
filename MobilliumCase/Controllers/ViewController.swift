//
//  ViewController.swift
//  MobilliumCase
//
//  Created by İlayda Öner on 17.11.2022.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var flights: [Flight] = [] {
       didSet {
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
       }
   }
    var upcomingFlights: [Flight] = [] {
       didSet {
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
       }
   }
    var outDatedFlights: [Flight] = [] {
       didSet {
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
       }
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        APIHandler.sharedInstance.fetchingAPIData(url: FlightServiceEndpoint.upcomingUrlPath()) { apiData in
            //MARK: - Data Assigning
            self.upcomingFlights = apiData
            self.flights = apiData
        }
        APIHandler.sharedInstance.fetchingAPIData(url: FlightServiceEndpoint.pastUrlPath()) { apiData in
            self.outDatedFlights = apiData
            print(self.outDatedFlights)
            self.tableView.refreshControl = UIRefreshControl()
                        self.tableView.refreshControl?.addTarget(self, action: #selector(self.didPullToRefresh), for: .valueChanged)
        }
    }
    @objc private func didPullToRefresh() {
           print ("Start Refresh")
           DispatchQueue.main.async {
               self.tableView.refreshControl?.endRefreshing()
           }
       }

    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.flights = self.upcomingFlights
        } else if sender.selectedSegmentIndex == 1{
            self.flights = self.outDatedFlights
        }
    }
    
    
}
// MARK: TableView DataSource and Delegate Methods
extension ViewController: ConfigureTableView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
       cell.launchesNameLabel.text = flights[indexPath.row].name
        cell.launchesImageView.kf.setImage(with: URL(string: flights[indexPath.row].links?.patch?.small ?? "https://images2.imgbox.com/a9/9a/NXVkTZCE_o.png"))
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let name = flights[indexPath.row].name, let imageUrl = URL(string: flights[indexPath.row].links?.patch?.small ?? "https://images2.imgbox.com/a9/9a/NXVkTZCE_o.png") else { return }
          let attemp = flights[indexPath.row].cores
          let success = flights[indexPath.row].success
          let type = flights[indexPath.row].cores
          let upcoming = flights[indexPath.row].upcoming

        if flights.count == upcomingFlights.count {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpcomingLaunchViewController") as? UpcomingLaunchViewController {
                viewController.launchString = name
                viewController.launchImageUrl = imageUrl
                viewController.attempString = (attemp != nil)
//                viewController.succesString = success
//                viewController.typeString = type
//                viewController.upcomingString = upcoming
                
                
                
                  if let navigator = navigationController {
                      navigator.pushViewController(viewController, animated: true)
                  }
              }
        }else {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PastLaunchViewController") as? PastLaunchViewController {
                  viewController.launchString = name
                viewController.launchImageUrl = imageUrl
                  if let navigator = navigationController {
                      navigator.pushViewController(viewController, animated: true)
                  }
              }
           
        }
        
   

    }
}
