//
//  GalleryCollectionView.swift
//  Messenger
//
//  Created by Polly on 01.07.2022.
//

import UIKit

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var userPhotos: [ItemPhoto] = []
    var selectedImages = [UIImage]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        delegate = self
        dataSource = self
        
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseID)
       
           
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseID, for: indexPath) as! GalleryCollectionViewCell
        
        ImageCaching.shared.fetchImage(withURL: userPhotos[indexPath.row].sizes[2].url) { (image) in
            cell.mainImageView.image = image
        }
        cell.mainImageView.contentMode = .scaleAspectFit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.bounds.width, height: 600)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GalleryCollectionViewCell
        guard let image = cell.mainImageView.image else { return }
        selectedImages.append(image)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GalleryCollectionViewCell
        guard let image = cell.mainImageView.image else { return }
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
    }
    
    
}
