//
//  DisasterViewController.swift
//  NasaSpaceApps2018
//
//  Created by Paloma Bispo on 20/10/18.
//  Copyright © 2018 Levy Cristian . All rights reserved.
//

import UIKit

class DisasterViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var myDisasters: [Disaster] = []
    let minimumInteritemSpacing: CGFloat = 10
    let minimumLineSpacing:CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "DisastersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellDisaster")

        // Do any additional setup after loading the view.
    }
    

    @IBAction func edit(_ sender: Any) {
        
    }
    @IBAction func bunker(_ sender: Any) {
        
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

extension DisasterViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let query = NSPredicate(format: "isMine = true")
        myDisasters = DataManager.executeThe(query: query, forEntityName: "Disaster") as? [Disaster] ?? []
        return myDisasters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDisaster", for: indexPath) as! DisastersCollectionViewCell
        
        let disaster = myDisasters[indexPath.row]
        cell.lblName.text = disaster.name
        guard let imageData = disaster.image else {
            cell.image.image = UIImage(named: "image")
            return cell
        }
        cell.image.image = UIImage(data: imageData)
        
        //cell.lblName.text = "teste"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = self.collectionView.frame.size.width - (minimumInteritemSpacing + minimumLineSpacing)
        return CGSize.init(width: itemWidth/2, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    
    
    
}
