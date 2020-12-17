//
//  CafeCollectionViewController.swift
//  CityCafe
//
//  Created by 翁淑惠 on 2020/12/15.
//

import UIKit

//private let reuseIdentifier = "\(CafeCollectionViewCell.self)"

class CafeCollectionViewController: UICollectionViewController {
    
    var stores = [CafeStore]()
    
    func fetchStores(city: String) {
        if let urlStr = "https://cafenomad.tw/api/v1.2/cafes/taipei".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlStr) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode([CafeStore].self, from: data)
                        self.stores = result
                        
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    } catch {
                            print(error)
                        }
                    
                }
            }.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        fetchStores(city: city.taipei.rawValue)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return stores.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CafeCollectionViewCell.self)", for: indexPath) as! CafeCollectionViewCell
    
        // Configure the cell
        let store = stores[indexPath.row]
        cell.nameLabel.text = store.name
        cell.cityLabel.text = store.city
        
        let tasty = store.tasty ?? 0.0
        var star = ""
        if tasty > 0 {
            for _ in 1...Int(tasty) {
                star += "⭐️"
            }
        }
        cell.tastyLabel.text = star
    
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
    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> DetailViewController? {
        guard let row = collectionView.indexPathsForSelectedItems?.first?.row else {
            return nil
        }
        return DetailViewController(coder: coder, store: stores[row])
    }
    
}
