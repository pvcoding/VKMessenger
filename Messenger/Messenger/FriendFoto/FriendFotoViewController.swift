//
//  FriendFotoViewController.swift
//  Messenger
//
//  Created by Polly on 08.01.2022.
//

import UIKit

private let reuseIdentifier = "friendFoto"

class FriendFotoViewController: UICollectionViewController {
    
    private let networkManager = NetworkManager.shared
  
    var userFotoId = Int()

    private var userPhotos: [ItemPhoto] = []
    
    private let itemsForRow: CGFloat = 3
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadPhotoData()
    }
    
    private func loadPhotoData() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.networkManager.loadFotos(token: SessionInfo.shared.token, userId: self.userFotoId) { [weak self] (photos) in
                
                DispatchQueue.main.async {
                    self?.userPhotos = photos
                    self?.collectionView.reloadData()
                }
            }
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickPhotoSegue" {
            let photoVC = segue.destination as! PhotoViewController
            let indexPath =  collectionView.indexPathsForSelectedItems?.first
            print(indexPath!)
            photoVC.indexPath = indexPath
            photoVC.galleryCollectionView.userPhotos = self.userPhotos
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return userPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendFoto", for: indexPath) as! FriendFotoViewCell

        let photoModel = userPhotos[indexPath.row]
        cell.photoModel = photoModel

        return cell
    }
}


extension FriendFotoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsForRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsForRow
       
        return CGSize(width: widthPerItem, height: widthPerItem)
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
