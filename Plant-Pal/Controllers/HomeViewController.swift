//
//  HomeViewController.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 6/9/24.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup if needed
//        view.backgroundColor = .white
    }
    
    @IBAction func addPlantButton(_ sender: UIButton) {
        let viewController = ViewController()
            navigationController?.pushViewController(viewController, animated: true)
        }
    
    @IBAction func myPlantsButton(_ sender: UIButton) {
        let myPlantsViewController = MyPlantsViewController()
            navigationController?.pushViewController(myPlantsViewController, animated: true)
    }
    @IBAction func settingsButton(_ sender: UIButton) {
        let settingsViewController = SettingsViewController()
            navigationController?.pushViewController(settingsViewController, animated: true)
    }
    //
//    // Prepare for the segue if you need to pass any data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewController" {
            if segue.destination is ViewController {
                // Pass data to the destination view controller if needed
            }
        }
    }
}
