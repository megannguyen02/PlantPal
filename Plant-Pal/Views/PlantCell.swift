//
//  PlantCell.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 5/22/24.
//

import Foundation
import UIKit

class PlantCell: UITableViewCell {
    
    static let identifier = "PlantCell"
    
    //Mark - Variables
    private(set) var plant: Plant!
    
    //Mark - UI Components
    private let plantImg : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .black
        return iv
    }()
    
    private let plantName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
//        label.font = systemFont(ofSize: 22)
        label.text = "Error"
        return label
    }()
    
    
    //MARK - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with plant: Plant){
        self.plant = plant
        
        self.plantName.text = plant.name
                
        if let imageUrl = URL(string: plant.image) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async { [weak self] in
                        self?.plantImg.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.plantName.text = nil
        self.plantImg.image = nil
    }
    
    //MARK - UI Setup
    private func setupUI() {
        self.addSubview(plantImg)
        self.addSubview(plantName)
        
        plantImg.translatesAutoresizingMaskIntoConstraints = false
        plantName.translatesAutoresizingMaskIntoConstraints = false
                
        
        NSLayoutConstraint.activate([
            plantImg.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            plantImg.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            plantImg.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            plantImg.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            plantName.leadingAnchor.constraint(equalTo: plantImg.trailingAnchor, constant: 16),
            plantName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            

        ])
    }
    
}
