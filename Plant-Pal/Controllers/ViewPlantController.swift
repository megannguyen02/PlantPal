//
//  ViewPlantController.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 5/24/24.
//

import UIKit

class ViewPlantController: UIViewController {

    // MARK: - Variables
    let viewModel: ViewPlantControllerViewModel
        
        // MARK: - UI Components
        private let scrollView: UIScrollView = {
           let sv = UIScrollView()
            return sv
        }()
        
        private let contentView: UIView = {  
           let view = UIView()
            return view
        }()
        
        private let plantImg: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.image = UIImage(systemName: "questionmark")
            iv.tintColor = .label
            return iv
        }()
        
    private let name: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .semibold)
            label.text = "Error"
            return label
        }()
        
        private let sciName: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .semibold)
            label.text = "Error"
            return label
        }()
        
        private let humidityLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .semibold)
            label.text = "Error"
            return label
        }()
//        
        private let soilMoistureLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .semibold)
            label.numberOfLines = 500
            return label
        }()
    
        private let uvLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .semibold)
            label.numberOfLines = 500
            return label
        }()
        
        private lazy var vStack: UIStackView = {
           let vStack = UIStackView(arrangedSubviews: [sciName, humidityLabel, soilMoistureLabel, uvLabel])
            vStack.axis = .vertical
            vStack.spacing = 12
            vStack.distribution = .fill
            vStack.alignment = .center
            return vStack
        }()
    
        private let addButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
            button.setTitle("Add to My Plants", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(.systemGreen, for: .normal)
            button.tintColor = .systemGreen
            button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            return button
        }()
    
        // MARK: - LifeCycle
        init(_ viewModel: ViewPlantControllerViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.setupUI()
            
            self.view.backgroundColor = .systemBackground
            self.navigationItem.title = self.viewModel.nameLabel
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
            
            self.name.text = self.viewModel.nameLabel
            self.sciName.text = self.viewModel.sciNameLabel
            self.humidityLabel.text = self.viewModel.humidityLabel
            
            self.soilMoistureLabel.text = self.viewModel.soilMoistureLabel
            self.uvLabel.text = self.viewModel.uvLabel
            
            self.viewModel.onImageLoaded = { [weak self] image in
            DispatchQueue.main.async {
                self?.plantImg.image = image
                }
            }
            
            restoreButtonState()
            
            // Add observer for ClearCacheNotification
//            NotificationCenter.default.addObserver(self, selector: #selector(clearButtonState), name:
//                Notification.Name("ClearCacheNotification"), object: nil)
            
//            if let imageUrl = URL(string: self.viewModel.plant.image) {
//                DispatchQueue.global().async {
//                    if let imageData = try? Data(contentsOf: imageUrl) {
//                        DispatchQueue.main.async { [weak self] in
//                            self?.plantImg.image = UIImage(data: imageData)
//                        }
//                    }
//                }
//            }
//            print("Button added to view: \(addButton.isDescendant(of: self.view))")
        }
        
        
        // MARK: - UI Setup
        private func setupUI() {
            self.view.addSubview(scrollView)
            self.scrollView.addSubview(contentView)
            self.contentView.addSubview(plantImg)
            self.contentView.addSubview(addButton)
            self.contentView.addSubview(vStack)
            
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
            plantImg.translatesAutoresizingMaskIntoConstraints = false
            vStack.translatesAutoresizingMaskIntoConstraints = false
            addButton.translatesAutoresizingMaskIntoConstraints = false
            
            let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            height.priority = UILayoutPriority(1)
            height.isActive = true
            
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
                scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
                scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                
                plantImg.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                plantImg.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
                plantImg.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                plantImg.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
                plantImg.heightAnchor.constraint(equalToConstant: 200),
                
                addButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                addButton.topAnchor.constraint(equalTo: plantImg.bottomAnchor, constant: 20),
                addButton.widthAnchor.constraint(equalToConstant: 200), // Adjust the width as needed
                addButton.heightAnchor.constraint(equalToConstant: 44), // Adjust the height as needed
                
                vStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                vStack.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20), // Place vStack below addButton
                vStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                vStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
                vStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
            ])
        }
    
    // MARK: - Add Button Action
        @objc private func addButtonTapped() {
//            let isCurrentlyAdded = addButton.imageView?.image == UIImage(systemName: "checkmark.circle.fill")
//                let imageName = isCurrentlyAdded ? "plus.circle" : "checkmark.circle.fill"
//                addButton.setImage(UIImage(systemName: imageName), for: .normal)
//                
//                if isCurrentlyAdded {
//                    removePlantFromMyPlants()
//                } else {
//                    savePlantToMyPlants()
//                }
            let isCurrentlyAdded = addButton.imageView?.image == UIImage(systemName: "checkmark.circle.fill")
                let imageName = isCurrentlyAdded ? "plus.circle" : "checkmark.circle.fill"
                addButton.setImage(UIImage(systemName: imageName), for: .normal)
                            
                if isCurrentlyAdded {
                    removePlantFromMyPlants()
                } else {
//                    savePlantToMyPlants()
                    // Add the newly saved plant to MyPlants
                    PlantDataManager.shared.addPlant(viewModel.plant)
                }
                
                // Save button state
                saveButtonState(isChecked: !isCurrentlyAdded)

        }
    
    private func savePlantToMyPlants() {
        var myPlants: [Plant] = UserDefaults.standard.object(forKey: "MyPlants") as? [Plant] ?? []
        let newPlant = viewModel.plant
        if !myPlants.contains(where: { $0.name == newPlant.name }) {
            myPlants.append(newPlant)
            if let encodedData = try? JSONEncoder().encode(myPlants) {
                UserDefaults.standard.set(encodedData, forKey: "MyPlants")
            }
        }
        
//        var myPlants = UserDefaults.standard.array(forKey: "MyPlants") as? [[String: Any]] ?? []
//        let plantData: [String: Any] = [
//            "name": viewModel.nameLabel,
//            "sciName": viewModel.sciNameLabel,
//            "image": viewModel.plant.image
//        ]
//        
//        if !myPlants.contains(where: { $0["name"] as? String == plantData["name"] as? String }) {
//            myPlants.append(plantData)
//            UserDefaults.standard.setValue(myPlants, forKey: "MyPlants")
//        }
    }
    
    private func removePlantFromMyPlants() {
        var myPlants: [Plant] = UserDefaults.standard.object(forKey: "MyPlants") as? [Plant] ?? []
        if let index = myPlants.firstIndex(where: { $0.name == viewModel.nameLabel }) {
            myPlants.remove(at: index)
            if let encodedData = try? JSONEncoder().encode(myPlants) {
                UserDefaults.standard.set(encodedData, forKey: "MyPlants")
            }
        }    }
    
    private func saveButtonState(isChecked: Bool) {
        UserDefaults.standard.setValue(isChecked, forKey: "addButtonState_\(viewModel.nameLabel)")
    }
    
    private func restoreButtonState() {
        let isChecked = UserDefaults.standard.bool(forKey: "addButtonState_\(viewModel.nameLabel)")
        let imageName = isChecked ? "checkmark.circle.fill" : "plus.circle"
        addButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
