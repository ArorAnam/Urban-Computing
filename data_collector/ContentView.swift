//
//  ContentView.swift
//  data_collector
//
//  Created by Naman Arora on 16/10/2023.
//

import SwiftUI
import CoreData
import MapKit
import CoreLocation
import CoreLocationUI
import CoreMotion

extension CLLocationCoordinate2D {
    static let parking = CLLocationCoordinate2D(latitude: 53.489778, longitude: -2.214486)
}

struct ContentView: View {
    
    @State private var selectedTag: Int?
    @State private var altitude: Double = 0.0
    let altitudeManager = CLLocationManager()
    let motionManager = CMMotionManager()
    var current_date_time = ""

    @ObservedObject var locationManager = LocationManager()

    var body: some View {
        Map(selection: $selectedTag){
            Marker("Start Point", coordinate: .parking)
                .tint(.blue)
                .tag(1)
        }
        .mapStyle(.standard(elevation: .realistic))

        VStack{
            Text("\(String(format: "%.0f", locationManager.degrees))°".uppercased())

            if let myLocation = locationManager.location{
                Text("Latitude: \(myLocation.latitude.formatted(.number.precision(.fractionLength(3)))), Longitude: \(myLocation.longitude.formatted(.number.precision(.fractionLength(3))))")
            } else {
                LocationButton{
                    locationManager.requestLocation()
                }
                .labelStyle(.iconOnly)
                .cornerRadius(20)
            }

            if let altitude = altitudeManager.location?.altitude {
                Text("\(String(format: "%.3f", altitude))m")
            }

            if let accelerometerData = motionManager.accelerometerData {
                Text("\(accelerometerData)")
            }

            if let gyroData = motionManager.gyroData {
                Text("\(gyroData)")
            }

        }
        .onAppear(){
            altitudeManager.requestWhenInUseAuthorization()
            altitudeManager.startUpdatingLocation()
            motionManager.startGyroUpdates()
            motionManager.startAccelerometerUpdates()
        }

        if let altitude_data = altitudeManager.location, let accelerator_Data = motionManager.accelerometerData, let gyro_Data = motionManager.gyroData{
            let _ = print("\(String(describing: locationManager.degrees)), \(String(describing: accelerator_Data.acceleration.x)), \(String(describing: accelerator_Data.acceleration.y)), \(String(describing: accelerator_Data.acceleration.z)), \(String(describing: gyro_Data.rotationRate.x)), \(String(describing: gyro_Data.rotationRate.y)), \(String(describing: gyro_Data.rotationRate.z)), \(String(describing: altitude_data.altitude)), \(String(describing: getTime()))")
        }
    }

}


func getTime() -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.dateStyle = .long
    let dateString = formatter.string(from: Date())
    return dateString

}


