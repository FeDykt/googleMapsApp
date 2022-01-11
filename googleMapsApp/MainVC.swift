//
//  MainVC.swift
//  googleMapsApp
//
//  Created by fedot on 11.01.2022.
//

import UIKit
import GoogleMaps

class MainVC: UIViewController {
    
    var mapView: GMSMapView!
    let network = NetworkDecode()
    var arrayMapsModel: [MapsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMap()
    }
    
    func createMap() {
        let defaultLocation = CLLocation(latitude: 49.07070102, longitude: 9.76366923)
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: 25)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        
        mapView.settings.myLocationButton = false
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(mapView)
        
        DispatchQueue.main.async {
            self.getReguest()
        }
        
        draw()
        
    }
    
    func getReguest() {
        network.getDecode { result in
            switch result {
            case .success(let success):
                guard let success = success else { return }
                self.arrayMapsModel = [success]
                
                self.arrayMapsModel.forEach { $0.points.forEach { result in
                    let long = result.geometry.coordinates[0]
                    let lat = result.geometry.coordinates[1]
                    let marker = GMSMarker()
                    
                    let r = result.properties.color[0]
                    let g = result.properties.color[1]
                    let b = result.properties.color[2]
                    
                    let alpha = result.properties.color[3]
                    
                    marker.icon = GMSMarker.markerImage(with: UIColor(red: r, green: g, blue: b, alpha: alpha))
                    marker.position = CLLocationCoordinate2DMake(lat, long)
                    marker.map = self.mapView
                    }
                }
        
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func draw() {
        let path = GMSMutablePath()
        
        path.add(CLLocationCoordinate2D(latitude: 49.07065733, longitude: 9.76360944))
        path.add(CLLocationCoordinate2D(latitude: 49.07063189, longitude: 9.76390329))
        
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .black
        polyline.strokeWidth = 10.0
        polyline.map = mapView
    }
}
