//
//  GPSTrackViewController.swift
//  GPSTrackDemo
//
//  Created by Ruchika Bokadia on 06/01/22.
//

import UIKit
import GoogleMaps

class GPSTrackViewController: UIViewController, GMSMapViewDelegate {

    var viewModel:DeviceListModel?
    var viewPositionModel:PositionListModel?
    
    var london: GMSMarker?
    var londonView: UIImageView?
    var timer: Timer?
    
    //RB
    var markers = [GMSMarker]()

    @IBOutlet weak var gMapView: GMSMapView!
    
    var currentLat : Double = Double()
    var currentLong : Double = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.gMapView.delegate = self
        
        
//        timer = Timer(timeInterval: 5, repeats: true) { [weak self] _ in
////            self?.callAPIFromTimer()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = false
       }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.navigationController?.navigationBar.isHidden = false
        self.viewModel = DeviceListModel.init(withDelegate: self)
        self.viewPositionModel = PositionListModel.init(withDelegate: self)
        
        self.setUpControls()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    
    func setUpUI() {
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.titleView?.tintColor = .black
        
        //Logout
        var image = UIImage(named: "logout")
        image = image?.withRenderingMode(.alwaysOriginal)
        let button1 = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(btnTapped))
//            UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(btnTapped))
        
        self.navigationItem.rightBarButtonItem  = button1
        
    }
    
    @objc func btnTapped() {
        UserDefaults.standard.set(nil, forKey: "is_login")
        UIAlertController.showAlert(andMessage: "Are you sure you want to logout.", andButtonTitles: ["YES","NO"]) { index in
            if index == 0{
                print("YES")
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                              let appDelegate = UIApplication.shared.delegate as! AppDelegate
                              let loginViewController = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                              let navco = UINavigationController(rootViewController: loginViewController)
                              appDelegate.window?.rootViewController = navco
                              appDelegate.window?.makeKeyAndVisible()

            }
        }
    }
    
    func setUpControls()
    {
        self.viewModel?.fetchDeviceList()
        self.viewPositionModel?.fetchPositionList(sessionId: RBUser.current.sessionIdGps, userID: RBUser.current.userIdApp)
//        self.gMapView.delegate = self

    }
    
    
    func callAPIFromTimer() {
        self.viewPositionModel?.fetchPositionList(sessionId: RBUser.current.sessionIdGps, userID: RBUser.current.userIdApp)
    }
  

}


extension GPSTrackViewController : DeviceListModelProtocol{
 
    
    func failedToGetDevices(withError error: Error) {
        print("Failes to list")
    }
    
    func didReceive(devices aryDevices: [GPSTrackViewModel]) {
        print(aryDevices)
    }
    
}


extension GPSTrackViewController : PositionListModelProtocol{
    func didReceive() {
        
        for (index, _) in markers.enumerated() {
            self.markers[index].map = nil
        }
        
        markers = []
        
        for (index,location) in (self.viewPositionModel?.positions ?? []).enumerated(){

            
                 let position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                 let marker = GMSMarker()
                 marker.position = position
                 marker.title = "Pin \(index)"
                 markers.append(marker)
                 marker.map = gMapView
                 print(marker)
       
        }
        
     
        DispatchQueue.main.async {
          
            let position = CLLocationCoordinate2D(latitude: self.viewPositionModel?.positions[0].latitude ?? 0.0, longitude: self.viewPositionModel?.positions[0].longitude ?? 0.0)
            
            
            let positionLast = CLLocationCoordinate2D(latitude: self.viewPositionModel?.positions[2].latitude ?? 0.0, longitude: self.viewPositionModel?.positions[2].longitude ?? 0.0)
            
            
            let boundsMap = GMSCoordinateBounds(coordinate: position, coordinate: positionLast)
            let update = GMSCameraUpdate.fit(boundsMap, with: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100))
            self.gMapView!.moveCamera(update)
        }
        
    }
    
    
     func failedToGetPositions(withError error: Error) {
        print("Failes to list")
    }
    
    
}

