//
//  MeaningCell.swift
//  SkyengDictionary
//
//  Created by Екатерина Батеева on 12.04.2021.
//

import UIKit

class MeaningCell: UITableViewCell {
    var model: MeaningViewModel

    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var label = UILabel()
    
    // MARK: Initialization
    
    init(model: MeaningViewModel) {
        self.model = model
        super.init(style: .default, reuseIdentifier: "meaningCell")
        label.text = model.text
        previewImageView.image = prepareImage(model.image)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   func setupLayout() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        contentView.addSubview(previewImageView)
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                previewImageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
                previewImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ])
    }
    
    // MARK: Private
    
    func prepareImage(_ image: UIImage?) -> UIImage? {
        return image?.resize(with: 0.5)
    }
}
