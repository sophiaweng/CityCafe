//
//  DetailViewController.swift
//  CityCafe
//
//  Created by 翁淑惠 on 2020/12/15.
//

import UIKit
import MapKit
import SafariServices

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var opentimeLabel: UILabel!
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var storeMapView: MKMapView!
    let store: CafeStore
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = store.name
        if let address = store.address {
            addressLabel.text = address
        }
        if let open_time = store.open_time {
            opentimeLabel.text = open_time
        }
        if let url = store.url {
            urlButton.setTitle(url, for: .normal)
        }
        if let latitude = store.latitude,
           let longitude = store.longitude {
            showMap(title: store.name, latitude: Double(latitude)!, longitude: Double(longitude)!)
        }
        
    }
    
    init?(coder: NSCoder, store: CafeStore) {
        self.store = store
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showMap(title: String, latitude: Double, longitude: Double) {
        let locationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        storeMapView.region = MKCoordinateRegion(center: locationCoordinate2D, latitudinalMeters: 500, longitudinalMeters: 500)
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = title
        pointAnnotation.coordinate = locationCoordinate2D
        storeMapView.addAnnotation(pointAnnotation)
    }
    
    @IBAction func showWeb(_ sender: UIButton) {
        if let url = URL(string: sender.title(for: .normal)!) {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
        }
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
