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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        cell.launchesDateLabel.text = dateFormatter.string(from: flights[indexPath.row].dateLocal ?? Date())
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if flights.count == upcomingFlights.count {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpcomingLaunchViewController") as? UpcomingLaunchViewController {
                viewController.launchString = flights[indexPath.row].name ?? "Unknown Name"
                viewController.launchImageUrl = URL(string: flights[indexPath.row].links?.patch?.small ?? "https://images2.imgbox.com/a9/9a/NXVkTZCE_o.png")
                viewController.upcomingString = flights[indexPath.row].upcoming ?? true
                (viewController.attempString = (flights[indexPath.row].cores != nil))
                viewController.succesString = flights[indexPath.row].success ?? true
                viewController.numberString = flights[indexPath.row].flightNumber ?? 91
                viewController.youtubeUrlString = flights[indexPath.row].links?.webcast ?? ""
                viewController.pressKitUrlString = flights[indexPath.row].links?.presskit ?? ""
                viewController.dateString = flights[indexPath.row].datePrecision ?? "hour"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd"
                viewController.launchDateString = dateFormatter.string(from: flights[indexPath.row].dateLocal ?? Date())
                
                
                  if let navigator = navigationController {
                      navigator.pushViewController(viewController, animated: true)
                  }
              }
        }else {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PastLaunchViewController") as? PastLaunchViewController {
                  viewController.launchString = flights[indexPath.row].name ?? "Unknown Name"
                viewController.launchImageUrl = URL(string: flights[indexPath.row].links?.patch?.small ?? "https://images2.imgbox.com/a9/9a/NXVkTZCE_o.png")
                viewController.upcomingString = flights[indexPath.row].upcoming ?? true
                viewController.attempString = (flights[indexPath.row].cores != nil)
                viewController.succesString = flights[indexPath.row].success ?? true
                viewController.numberString = flights[indexPath.row].flightNumber ?? 91
                viewController.youtubeUrlString = flights[indexPath.row].links?.webcast ?? ""
                viewController.pressKitUrlString = flights[indexPath.row].links?.presskit ?? ""
                viewController.dateString = flights[indexPath.row].datePrecision ?? "hour"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd"
                viewController.launchDateString = dateFormatter.string(from: flights[indexPath.row].dateLocal ?? Date())
                  if let navigator = navigationController {
                      navigator.pushViewController(viewController, animated: true)
                  }
              }
           
        }
        
   

    }
}
