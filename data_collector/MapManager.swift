//
//  MapManager.swift
//  data_collector
//
//  Created by Naman Arora on 05/11/2023.
//

import Foundation
import MapKit

final class MapManager: NSObject, ObservableObject{

    private let mapManager = CLLocationManager()

    @Published var region_when_launch = MKCoordinateRegion(
        center: .init(latitude: 53.3373689, longitude: -6.2840002), span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    override init() {
        super.init()

        self.mapManager.delegate = self
        self.mapManager.desiredAccuracy = kCLLocationAccuracyBest
        self.setup()
    }

    func setup() {
        switch mapManager.authorizationStatus {
        case .authorizedWhenInUse:
            mapManager.requestLocation()
        case .notDetermined:
            mapManager.startUpdatingLocation()
            mapManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }

}

extension MapManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        mapManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: (error)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapManager.stopUpdatingLocation()
        locations.last.map {
            region_when_launch = MKCoordinateRegion(
                center: $0.coordinate,
                span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }
}
