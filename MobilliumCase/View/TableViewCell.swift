//
//  TableViewCell.swift
//  MobilliumCase
//
//  Created by İlayda Öner on 17.11.2022.
//


import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var launchesDateLabel: UILabel!
    @IBOutlet weak var launchesNameLabel: UILabel!
    @IBOutlet weak var launchesImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI () {
        holderView.layer.cornerRadius = 10
        holderView.layer.borderColor = UIColor.lightGray.cgColor
        holderView.layer.borderWidth = 0.7
        launchesImageView.layer.borderWidth = 1.0
        launchesImageView.layer.masksToBounds = false
        launchesImageView.layer.cornerRadius = launchesImageView.frame.size.height/2
        launchesImageView.clipsToBounds = true
    }

}

