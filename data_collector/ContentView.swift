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
    static let parking = CLLocationCoordinate2D(latitude: 53.34156, longitude: -6.25321)
}

struct ContentView: View {
    
    @State private var selectedTag: Int?
    @State private var altitude: Double = 0.0
    let altitudeManager = CLLocationManager()
    let motionManager = CMMotionManager()
    var current_date_time = ""

    @ObservedObject var locationManager = LocationManager()

    var body: some View {
            ZStack{
                Map(selection: $selectedTag){
                    Marker("Start Point", coordinate: .parking)
                        .tint(.blue)
                        .tag(1)
                }
                .mapStyle(.standard(elevation: .realistic))
                .safeAreaInset(edge: .bottom) {
                    
                    VStack{
                        Text("Magnetometer")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Direction: \(String(format: "%.0f", locationManager.degrees))°")
                        Text("Accelerometer")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        if let accelerometerData = motionManager.accelerometerData {
                            Text("X: \(accelerometerData.acceleration.x), Y: \(accelerometerData.acceleration.y), Z: \(accelerometerData.acceleration.z)")
                        }

                        Text("Gyroscope")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        if let gyroData = motionManager.gyroData {
                            Text("X: \(gyroData.rotationRate.x), Y: \(gyroData.rotationRate.y), Z: \(gyroData.rotationRate.z)")
                        }

                        if let myLocation = locationManager.location, let altitude = altitudeManager.location{
                            Text("Barometer")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("Altitude: \(String(format: "%.3f", altitude.altitude))m")
                            Text("GPS")
                                .font(.title3)
                                .fontWeight(.semibold)

                            Text("Latitude: \(myLocation.latitude.formatted(.number.precision(.fractionLength(3)))), Longitude: \(myLocation.longitude.formatted(.number.precision(.fractionLength(3))))")
                        } else {
                            LocationButton{
                                locationManager.requestLocation()
                            }
                            .labelStyle(.iconOnly)
                            .cornerRadius(20)
                        }
                    }
                    .onAppear(){
                        altitudeManager.requestWhenInUseAuthorization()
                        altitudeManager.startUpdatingLocation()
                        motionManager.startGyroUpdates()
                        motionManager.startAccelerometerUpdates()

                    }
                    .frame(width: 350, height: 300)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
            }
        
//        if let data = altitudeManager.location, let data_2 = locationManager.location{
//
//                let _ = print("\(String(describing: data_2.latitude )), \(String(describing: data_2.longitude)), \(locationManager.degrees), \(data.altitude), \(getTime())")
//
//        }


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


