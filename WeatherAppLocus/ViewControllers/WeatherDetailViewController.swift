//
//  WeatherDetailViewController.swift
//  WeatherAppLocus
//
//  Created by Shobhit Jain on 13/03/22.
//

import Foundation
import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    @IBOutlet weak var mainStatus: UILabel!
    @IBOutlet weak var descriptiveStatus: UILabel!
    
    var viewModel: WeatherDetailViewModel? {
        didSet {
            if self.isViewLoaded {
                setupView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupView() {
        self.tempLabel.text = self.viewModel?.report.temp
        self.feelsLikeTempLabel.text = self.viewModel?.report.feelsLike
        self.mainStatus.text = self.viewModel?.report.mainTitle
        self.descriptiveStatus.text = self.viewModel?.report.description
    }
}
