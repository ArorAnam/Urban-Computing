//
//  SensorView.swift
//  data_collector
//
//  Created by Naman Arora on 27/11/2023.
//


import SwiftUI
import CoreData
import MapKit
import CoreLocation
import CoreLocationUI
import CoreMotion
import Firebase


struct SensorView: View {

    @ObservedObject var locationManager = LocationManager()
    let motionManager = CMMotionManager()
    let altitudeManager = CLLocationManager()

    @State var StartUploading = false
    
    @State var StopButton = false
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    HStack{
                        Text("Magnetometer")
                            .font(.headline)

                            .fontWeight(.semibold)

                        Spacer()

                    }

                    Text("Direction: \(String(format: "%.0f", locationManager.degrees))°")

                }

                .padding()

                VStack{

                    HStack{

                        Text("Accelerometer")

                            .font(.headline)

                            .fontWeight(.semibold)

                        Spacer()

                    }

                    if let accelerometerData = motionManager.accelerometerData {

                        Text("X: \(accelerometerData.acceleration.x), Y: \(accelerometerData.acceleration.y), Z: \(accelerometerData.acceleration.z)")

                    }

                }

                .padding()

                VStack{

                    HStack{

                        Text("Gyroscope")

                            .font(.headline)

                            .fontWeight(.semibold)

                        Spacer()

                    }

                    if let gyroData = motionManager.gyroData {

                        Text("X: \(gyroData.rotationRate.x), Y: \(gyroData.rotationRate.y), Z: \(gyroData.rotationRate.z)")

                    }

                }

                .padding()

                if let myLocation = locationManager.location, let altitude = altitudeManager.location{

                    VStack{

                        HStack{

                            Text("Barometer")

                                .font(.headline)

                                .fontWeight(.semibold)

                            Spacer()

                        }

                        Text("Altitude: \(String(format: "%.3f", altitude.altitude))m")

                    }

                    .padding()

                    VStack{

                        HStack{

                            Text("GPS")

                                .font(.headline)

                                .fontWeight(.semibold)

                            Spacer()

                        }

                        Text("Latitude: \(myLocation.latitude.formatted(.number.precision(.fractionLength(3)))), Longitude: \(myLocation.longitude.formatted(.number.precision(.fractionLength(3))))")

                    }

                    .padding()

                    Divider()

                    VStack {

                        Button{

                            StartUploading = true

                        }label:{

                            HStack{

                                Image(systemName: "icloud.and.arrow.up")

                                Text("Save Data")

                            }

                        }

                        .buttonStyle(.borderedProminent)

                    }

                    .padding()

                    if StartUploading {

                        HStack(spacing: 20, content: {

                            Text("Uploading data now...")

                            if let altitude_data = altitudeManager.location, let location_data = locationManager.location, let accelerator_Data = motionManager.accelerometerData, let gyro_Data = motionManager.gyroData

                            {

                                let _ = uploadSensorData(magnetometer_direction: "\(locationManager.degrees)", accelerometer_x: "\(accelerator_Data.acceleration.x)", accelerometer_y: "\(accelerator_Data.acceleration.y)", accelerometer_z: "\(accelerator_Data.acceleration.z)", gyroscope_x: "\(gyro_Data.rotationRate.x)", gyroscope_y: "\(gyro_Data.rotationRate.y)", gyroscope_z: "\(gyro_Data.rotationRate.z)", barometer_altitude: "\(altitude_data.altitude)", gps_latitude: "\(String(describing: location_data.latitude))", gps_longitude: "\(String(describing: location_data.longitude))", source: "iPad", date_time_added: "\(getTime())")

                            }

                            Spacer()

                            Button{

                                StartUploading = false

                            }label:{

                                Text("Stop Upload")

                            }

                            .buttonStyle(.bordered)

                        }

                        )

                        .padding()

                    }

                } else {

                    LocationButton(.shareMyCurrentLocation){

                        locationManager.requestLocation()

                    }

                    .labelStyle(.titleAndIcon)

                    .frame(height: 40)

                    .cornerRadius(15)

                }

            }

        }

        .navigationTitle("Sensors Data")

        .onAppear(){

            altitudeManager.requestWhenInUseAuthorization()

            altitudeManager.startUpdatingLocation()

            motionManager.startGyroUpdates()

            motionManager.startAccelerometerUpdates()

        }

    }

}



func getTime() -> String {

    let formatter = DateFormatter()

    formatter.timeStyle = .long

    formatter.dateStyle = .long

    let dateString = formatter.string(from: Date())

    return dateString

}



func uploadSensorData(magnetometer_direction: String, accelerometer_x: String, accelerometer_y: String, accelerometer_z: String, gyroscope_x: String, gyroscope_y: String, gyroscope_z: String, barometer_altitude: String, gps_latitude: String, gps_longitude: String, source: String, date_time_added: String) {

    

    let uuid = UUID().uuidString

    let db = Firestore.firestore()

    

    db.collection("Sensor").document().setData([

        "row_id": uuid,

        "magnetometer_direction": magnetometer_direction,

        "accelerometer_x": accelerometer_x,

        "accelerometer_y": accelerometer_y,

        "accelerometer_z": accelerometer_z,

        "gyroscope_x": gyroscope_x,

        "gyroscope_y": gyroscope_y,

        "gyroscope_z": gyroscope_z,

        "barometer_altitude": barometer_altitude,

        "gps_latitude": gps_latitude,

        "gps_longitude": gps_longitude,

        "source": source,

        "date_time_added": date_time_added

    ], merge: true) { error in

        if let error = error {

            print("Error writing document: \(error)")

        } else {

            print("Document successfully written!")

        }

    }

}
