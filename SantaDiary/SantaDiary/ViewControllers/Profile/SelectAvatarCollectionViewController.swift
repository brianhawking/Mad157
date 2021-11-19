//
//  SelectAvatarCollectionViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/18/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class SelectAvatarCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let padding: CGFloat = 10
    let numberOfColumns: CGFloat = 2
    var imageSize: CGFloat = 0
    var selectedRow = -1
    
    public var completionHandler: ((Int) -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageSize = collectionView.bounds.size.width/numberOfColumns - padding

        // Register cell classes
        collectionView!.register(ACollectionViewCell.self, forCellWithReuseIdentifier: ACollectionViewCell.identifier)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveImage(_ sender: UIButton) {
        if (selectedRow != -1) {
            completionHandler?(selectedRow)
            // go back
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row, SantaImages().avatar[indexPath.row])
        if selectedRow == indexPath.row {
            selectedRow = -1
        } else {
            selectedRow = indexPath.row
        }
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDelegateFlow
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: imageSize, height: imageSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SantaImages().avatar.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ACollectionViewCell.identifier, for: indexPath) as! ACollectionViewCell
 
        cell.imageView.image = UIImage(named: SantaImages().avatar[indexPath.row])
        
        if selectedRow == indexPath.row {
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 2
        }
        else {
            cell.layer.borderWidth = 0
        }
        
        return cell
    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
