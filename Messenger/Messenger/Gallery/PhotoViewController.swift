//
//  PhotoViewController.swift
//  Messenger
//
//  Created by Polly on 16.06.2022.
//

import UIKit

class PhotoViewController: UIViewController {

    
    var image: UIImage?
    
    @IBOutlet weak var photoImageView: UIImageView!

    
    var indexPath: IndexPath!
 
    var galleryCollectionView = GalleryCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCollectionView()   
    }

    
    private func loadCollectionView() {
        self.view.addSubview(galleryCollectionView)
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        galleryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        galleryCollectionView.performBatchUpdates(nil) { (result) in
           
            self.galleryCollectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: false)
        }
        galleryCollectionView.allowsMultipleSelection = true
    }
    
    func refresh() {
        let alert = UIAlertController(title: "Успешно", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        self.galleryCollectionView.selectedImages.removeAll()
        self.galleryCollectionView.reloadData()
        
    }
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
       
        
        if galleryCollectionView.selectedImages.isEmpty {
            
            let alert = UIAlertController(title: "Выберите изображения", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)

        } else {
           
            let shareController = UIActivityViewController(activityItems: galleryCollectionView.selectedImages, applicationActivities: nil)
                   shareController.completionWithItemsHandler = { _ , bool, _ , _ in
                       if bool {
                        self.refresh()
                       }
                   }
                   shareController.popoverPresentationController?.barButtonItem = sender
                   shareController.popoverPresentationController?.permittedArrowDirections = .any
                   present(shareController, animated: true, completion: nil)
               }
        }   
}
