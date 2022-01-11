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
        
        DispatchQueue.main.async {
            self.getReguest()
        }
    }
    
    private func createMap() {
        
        let defaultLocation = CLLocation(latitude: 49.06681351, longitude: 9.7633608)
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: 15)
        
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        view.addSubview(mapView)
    }
    
    private func getReguest() {
        network.getDecode { result in
            switch result {
            case .success(let success):
                guard let success = success else { return }
                //MARK: Append result to array
                self.arrayMapsModel = [success]
                self.createPointsLines()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func createPointsLines() {
        self.arrayMapsModel.forEach {
            //MARK: Points marker
            $0.points.forEach { [weak self] points in
                guard let self = self else { return }
                
                let propertyName = points.properties.name
                let long = points.geometry.coordinates[0]
                let lat = points.geometry.coordinates[1]
                
                
                //MARK: Marker color:
                let r = points.properties.color[0]
                let g = points.properties.color[1]
                let b = points.properties.color[2]
                
                let alpha = points.properties.color[3]
                
                let marker = GMSMarker()
                marker.icon = GMSMarker.markerImage(with: UIColor(red: r, green: g, blue: b, alpha: alpha))
                marker.position = CLLocationCoordinate2DMake(lat, long)
                marker.map = self.mapView
                marker.title = propertyName
                
            }
            //MARK: draw lines
            $0.lines.forEach { lines in
                
                let firstLineFirstPoistLong = lines.geometry.coordinates[0][0]
                let firstLineFristPoistLat = lines.geometry.coordinates[0][1]
                
                let firstLineSecondPointLong = lines.geometry.coordinates[1][0]
                let firstLineSecondPointLat = lines.geometry.coordinates[1][1]
                

                
                let path = GMSMutablePath()
                
                if lines.geometry.coordinates.count > 3 {

                    let threeLineLong = lines.geometry.coordinates[2][0]
                    let threeLineLat = lines.geometry.coordinates[2][1]

                    let fourLineLong = lines.geometry.coordinates[3][0]
                    let fourLineLat = lines.geometry.coordinates[3][1]
                    
                    createLinesCountMoreThree(path: path, lon: firstLineFirstPoistLong,
                                              lat: firstLineFristPoistLat,
                                              secondLon: firstLineSecondPointLong,
                                              secondLat: firstLineSecondPointLat,
                                              trheeLineLong: threeLineLong,
                                              threeLineLat: threeLineLat,
                                              fourLineLong: fourLineLong,
                                              fourLineLat: fourLineLat)
                } else {
                    createLines(path: path, lon: firstLineFirstPoistLong, lat: firstLineFristPoistLat, secondLon: firstLineSecondPointLong, secondLat: firstLineSecondPointLat)
                }
                
                let line = GMSPolyline(path: path)
                line.strokeWidth = 2
                line.strokeColor = .red
  
                line.map = self.mapView
            }
        }
    }
    func createLines(path: GMSMutablePath, lon: Double, lat: Double, secondLon: Double, secondLat: Double) {
        path.addLatitude(lat, longitude: lon)
        path.addLatitude(secondLat, longitude: secondLon)
    }
    func createLinesCountMoreThree(path: GMSMutablePath, lon: Double, lat: Double, secondLon: Double, secondLat: Double, trheeLineLong: Double, threeLineLat: Double, fourLineLong: Double, fourLineLat: Double) {
        path.addLatitude(lat, longitude: lon)
        path.addLatitude(secondLat, longitude: secondLon)
        path.addLatitude(threeLineLat, longitude: trheeLineLong)
        path.addLatitude(fourLineLat, longitude: fourLineLong)
    }
}




