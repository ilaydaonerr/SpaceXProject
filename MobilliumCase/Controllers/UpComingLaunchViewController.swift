//
//  UpComingLaunchViewController.swift
//  MobilliumCase
//
//  Created by İlayda Öner on 19.11.2022.
//

import UIKit
import Kingfisher

class UpcomingLaunchViewController: UIViewController {

    @IBOutlet weak var launchName: UILabel!
    @IBOutlet weak var launchImage: UIImageView!
    
    @IBOutlet weak var launchDate: UILabel!
    
    @IBOutlet weak var launchHolder: UIView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    
    @IBOutlet weak var attemptLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var upcomingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var youtubeView: UIView!
    @IBOutlet weak var pressView: UIView!
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var fifthView: UIView!
    
    @IBOutlet weak var sixthView: UIView!
    
    var launchString = String()
    var launchImageUrl = URL(string: "")
    var typeString = String()
    var attempString = Bool()
    var succesString = Bool()
    var numberString = Int()
    var upcomingString = Bool()
    var hourString = Int()
    var minString = Int()
    var secString = Int()
    var dateString = String()
    var youtubeUrlString = String()
    var pressKitUrlString = String()
    var launchDateString = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButtons()
        configureUI()
     }
     
     func createButtons() {
         let youtubeGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapYoutube))
         youtubeGesture.numberOfTapsRequired = 1
         youtubeView?.isUserInteractionEnabled = true
         youtubeView?.addGestureRecognizer(youtubeGesture)
         
         let pressKitGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPressKit))
         pressKitGesture.numberOfTapsRequired = 1
         pressView?.isUserInteractionEnabled = true
         pressView?.addGestureRecognizer(pressKitGesture)
     }
     
     @objc func didTapYoutube() {
         if let url = URL(string: youtubeUrlString) {
             UIApplication.shared.open(url)
         }
     }
     @objc func didTapPressKit() {
         if let url = URL(string: pressKitUrlString) {
             UIApplication.shared.open(url)
         }
     }
    
    func configureUI () {
        launchImage.layer.cornerRadius = 22
        launchHolder.layer.cornerRadius = 10
        youtubeView.layer.cornerRadius = 10
        youtubeView.layer.borderColor = UIColor(named: "Primary20")?.cgColor
        youtubeView.layer.borderWidth = 1
        
        pressView.layer.cornerRadius = 10
        pressView.layer.borderColor = UIColor(named: "Primary20")?.cgColor
        pressView.layer.borderWidth = 1
        
        firstView.backgroundColor = .clear
        secondView.backgroundColor = .clear
        thirdView.backgroundColor = .clear
        fourthView.backgroundColor = .clear
        fifthView.backgroundColor = .clear
        sixthView.backgroundColor = .clear
        
        firstView.layer.borderColor = UIColor(named: "Primary20")?.cgColor
        firstView.layer.borderWidth = 1
        secondView.layer.borderColor = UIColor(named: "Primary20")?.cgColor
        secondView.layer.borderWidth = 1
        thirdView.layer.borderColor = UIColor(named: "Primary20")?.cgColor
        thirdView.layer.borderWidth = 1
        fourthView.layer.borderColor = UIColor(named: "Primary20")?.cgColor
        fourthView.layer.borderWidth = 1
        fifthView.layer.borderColor = UIColor(named: "Primary20")?.cgColor
        fifthView.layer.borderWidth = 1
        sixthView.layer.borderColor = UIColor(named: "Primary20")?.cgColor
        sixthView.layer.borderWidth = 1
        
        firstView.roundCorners(corners: .topLeft, radius: 10)
        secondView.roundCorners(corners: .topRight, radius: 10)
        fifthView.roundCorners(corners: .bottomLeft, radius: 10)
        sixthView.roundCorners(corners: .bottomRight, radius: 10)
        
        launchName.text = launchString
        launchImage.kf.setImage(with: launchImageUrl)
        attemptLabel.text = String(attempString)
        successLabel.text = String(succesString)
        typeLabel.text = typeString
        numberLabel.text = String(numberString)
        upcomingLabel.text = String(upcomingString)
        hourLabel.text = String(hourString)
        minLabel.text = String(minString)
        secLabel.text = String(secString)
        dateLabel.text = dateString
        launchDate.text = launchDateString
    }
  


}
