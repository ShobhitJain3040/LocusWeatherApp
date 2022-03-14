//
//  ViewController.swift
//  WeatherAppLocus
//
//  Created by Shobhit Jain on 12/03/22.
//

import UIKit

class LookupViewController: UIViewController {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var cityTextField: UITextField!
    let viewModel = LookupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.showLoader.bind { [weak self] bool in
            if bool {
                self?.loadingView.isHidden = false
            } else {
                self?.loadingView.isHidden = true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func onLookupAction(_ sender: UIButton) {
        viewModel.getWeather(for: self.cityTextField.text ?? "") { result in
            switch result {
            case .success(let reports):
                self.routeToListingController(with: reports)
            case .failure(let error):
                self.showError(with: error.getMessage())
            }
        }
    }
    
    func routeToListingController(with data: WeatherReport) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherDetailViewController") as! WeatherDetailViewController
        let viewModel = WeatherDetailViewModel(data)
        controller.viewModel = viewModel
        self.navigationItem.backButtonTitle = self.cityTextField.text ?? "City Name"
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    func showError(with message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: false, completion: nil)
    }
}

