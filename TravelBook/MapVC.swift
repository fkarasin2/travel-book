//
//  MapVC.swift
//  TravelBook
//
//  Created by Hayrullah Faruk KARAŞIN on 21.03.2022.
//

import UIKit
import MapKit
import Parse

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapVİew: MKMapView!
    var locationManager = CLLocationManager()
    var choosenLatitude = ""
    var choosenLongitude = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButton))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButton))
        
        mapVİew.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocaiton(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3
        mapVİew.addGestureRecognizer(recognizer)
        
        
        
            }
    @objc func chooseLocaiton(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizer.State.began{
            let touches = gestureRecognizer.location(in: self.mapVİew)
            let coordinates = self.mapVİew.convert(touches, toCoordinateFrom: self.mapVİew)
            let annatotation = MKPointAnnotation()
            annatotation.coordinate = coordinates
            annatotation.title = PlaceModel.sharedInstance.placeName
            annatotation.subtitle = PlaceModel.sharedInstance.description
            
            self.mapVİew.addAnnotation(annatotation)
            
            PlaceModel.sharedInstance.placeLatitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.placeLongitude = String(coordinates.longitude)
            
            
        }
            
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapVİew.setRegion(region, animated: true)
    }
    @objc func saveButton(){
        let object = PFObject(className: "Location")
        object["name"] = PlaceModel.sharedInstance.placeName
        object["description"] = PlaceModel.sharedInstance.description
        object["latitude"] = PlaceModel.sharedInstance.placeLatitude
        object["longitude"] = PlaceModel.sharedInstance.placeLongitude
        
        if let imageData = PlaceModel.sharedInstance.placeImage.jpegData(compressionQuality: 0.5){
            let uuid = PlaceModel.sharedInstance.placeName
            
            object["image"] = PFFileObject(name: "\(uuid).jpg", data: imageData)
        
        }
        
        object.saveInBackground {(success, error) in
            if error != nil{
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }else{
                self.performSegue(withIdentifier: "fromMapVC", sender: nil)
            }
        }
        
    }
    @objc func backButton(){
        self.dismiss(animated: true, completion: nil)
    }
    func makeAlert(titleInput: String, messageInput:String) {
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
           let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
           alert.addAction(okButton)
           self.present(alert, animated: true, completion: nil)
       }
    
    

    

}
