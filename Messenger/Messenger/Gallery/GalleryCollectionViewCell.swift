//
//  GalleryCollectionViewCell.swift
//  Messenger
//
//  Created by Polly on 01.07.2022.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "GalleryCollectionViewCell"
    
     let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let checkMark: UIImageView = {
        let image = UIImage(named: "checkmark")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
    }
    
    override var isSelected: Bool{
        didSet {
            updateSelectedState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateSelectedState()
        setupPhotoImageView()
        setupCheckmarkView()
    }
    
    private func updateSelectedState() {
        mainImageView.alpha = isSelected ? 0.7 : 1
        checkMark.alpha = isSelected ? 1 : 0
    }
    
    private func setupCheckmarkView() {
        addSubview(checkMark)

        checkMark.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor).isActive = true
        checkMark.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor).isActive = true
    }
    
    private func setupPhotoImageView() {
        addSubview(mainImageView)
        
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
