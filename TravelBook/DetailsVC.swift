//
//  DetailsVC.swift
//  TravelBook
//
//  Created by Hayrullah Faruk KARAŞIN on 22.03.2022.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var DescriptionText: UITextField!
    @IBOutlet weak var detailsMapView: MKMapView!
    
    @IBOutlet weak var imageViewDetails: UIImageView!
    var chosenPlaceId = ""
    var chosenLatitude = Double()
        var chosenLongitude = Double()
    override func viewDidLoad() {
        super.viewDidLoad()


        getDataFromParse()
        detailsMapView.delegate = self
        
    }
    
    func getDataFromParse() {
        
        let query = PFQuery(className: "Location")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        let chosenPlaceObject = objects![0]
                        
                        // OBJECTS
                        
                        if let placeName = chosenPlaceObject.object(forKey: "name") as? String {
                            self.locationText.text = placeName
                        }
                        
                        if let placeType = chosenPlaceObject.object(forKey: "description") as? String {
                            self.DescriptionText.text = placeType
                        }
                        
                        
                        
                        if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                            if let placeLatitudeDouble = Double(placeLatitude) {
                                self.chosenLatitude = placeLatitudeDouble
                            }
                        }
                        
                        if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                            if let placeLongitudeDouble = Double(placeLongitude) {
                                self.chosenLongitude = placeLongitudeDouble
                            }
                        }
                        
                        if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground { (data, error) in
                                if error == nil {
                                    if data != nil {
                                    self.imageViewDetails.image = UIImage(data: data!)
                                    }
                                }
                            }
                        }
                        
                        let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    
                        let region = MKCoordinateRegion(center: location, span: span)
                        self.detailsMapView.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = self.locationText.text
                        annotation.subtitle = self.DescriptionText.text
                        self.detailsMapView.addAnnotation(annotation)
                        
                    }
                }
            }
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let reuseId = "pin"
        var pinview = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinview == nil{
            pinview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinview?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinview?.rightCalloutAccessoryView = button
        }else{
            pinview?.annotation = annotation
        }
        return pinview
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0{
            let requestLocations = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocations) { placemark, error in
                if let placemarks = placemark{
                    if placemarks.count > 0 {
                        let mkPlaceMark = MKPlacemark(placemark: placemarks[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.locationText.text
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOptions)
                        
                    }
                }
            }
        }
    }
    
}
