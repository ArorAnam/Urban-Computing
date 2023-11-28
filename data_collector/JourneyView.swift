//
//  JourneyView.swift
//  data_collector
//
//  Created by Naman Arora on 27/11/2023.
//

import SwiftUI

import CoreLocation

import CoreLocationUI

import CoreMotion

import Firebase





struct JourneyView: View {
    
    
    
    @ObservedObject var journeyLocationManager = LocationManager()
    
    @State var StartJourney = false
    
    @State var viewViz = false
    
    @State var EndJourney = false
    
    @State var isThereAFall = false
    
    let lines = linesList
    
    let AEL_stations = AEL
    
    let TCL_stations = TCL
    
    let TML_stations = TML
    
    let TKL_stations = TKL
    
    let EAL_stations = EAL
    
    let SIL_stations = SIL
    
    let TWL_stations = TWL
    
    let ISL_stations = ISL
    
    let KTL_stations = KTL
    
    @State private var line = ""
    
    @State private var station = ""
    
    let journeyMotionManager = CMMotionManager()
    
    @State private var showingAlert = false
    
    @State var dataFromFallDB:[String: Any] = ["": ""]
    
    
    
    @State var dataFromFallDb:[String: Any] = ["": ""]
    
    @State var accfromdb = [String]()
    
    @State var gyrofromdb = [String]()
    
    
    
    
    
    
    
    var body: some View {
        
        VStack{
            
            ScrollView{
                
                HStack{
                    
                    Text("Location")
                    
                        .font(.headline)
                    
                        .fontWeight(.semibold)
                    
                        .padding(.leading)
                    
                    Spacer()
                    
                }
                
                if let myLocation = journeyLocationManager.location{
                    
                    Text("Latitude: \(myLocation.latitude.formatted(.number.precision(.fractionLength(3)))), Longitude: \(myLocation.longitude.formatted(.number.precision(.fractionLength(3))))")
                    
                } else {
                    
                    LocationButton(.shareMyCurrentLocation){
                        
                        journeyLocationManager.requestLocation()
                        
                    }
                    
                    .labelStyle(.titleAndIcon)
                    
                    .frame(height: 40)
                    
                    .cornerRadius(15)
                    
                }
                
                VStack{
                    
                    HStack{
                        
                        Text("Accelerometer")
                        
                            .font(.headline)
                        
                            .fontWeight(.semibold)
                        
                            .padding(.leading)
                        
                        Spacer()
                        
                    }
                    
                    if let accelerometerData = journeyMotionManager.accelerometerData {
                        
                        Text("X: \(accelerometerData.acceleration.x), Y: \(accelerometerData.acceleration.y), Z: \(accelerometerData.acceleration.z)")
                        
                    }
                    
                }
                
                VStack{
                    
                    HStack{
                        
                        Text("Gyroscope")
                        
                            .font(.headline)
                        
                            .fontWeight(.semibold)
                        
                            .padding(.leading)
                        
                        Spacer()
                        
                    }
                    
                    if let gyroData = journeyMotionManager.gyroData {
                        
                        Text("X: \(gyroData.rotationRate.x), Y: \(gyroData.rotationRate.y), Z: \(gyroData.rotationRate.z)")
                        
                    }
                    
                }
                
                HStack{
                    
                    HStack{
                        
                        Text("Line:")
                        
                            .font(.headline)
                        
                            .fontWeight(.semibold)
                        
                            .padding(.leading)
                        
                        Picker("Line", selection: $line) {
                            
                            ForEach(lines, id: \.self) {
                                
                                Text($0)
                                
                            }
                            
                        }
                        
                        .pickerStyle(.menu)
                        
                    }
                    
                    Spacer()
                    
                    HStack{
                        
                        Text("Station:")
                        
                            .font(.headline)
                        
                            .fontWeight(.semibold)
                        
                        if line == "AEL"{
                            
                            Picker("Station", selection: $station) {
                                
                                ForEach(AEL_stations, id: \.self) {
                                    
                                    
                                    
                                    Text($0)
                                    
                                }
                                
                            }
                            
                            .pickerStyle(.menu)
                            
                        }
                        
                        if line == "TCL"{
                            
                            Picker("Station", selection: $station) {
                                
                                ForEach(TCL_stations, id: \.self) {
                                    
                                    Text($0)
                                    
                                }
                                
                            }
                            
                            .pickerStyle(.menu)
                            
                        }
                        
                        if line == "TML"{
                            
                            Picker("Station", selection: $station) {
                                
                                ForEach(TML_stations, id: \.self) {
                                    
                                    Text($0)
                                    
                                }
                                
                            }
                            
                            .pickerStyle(.menu)
                            
                        }
                        
                        if line == "TKL"{
                            
                            Picker("Station", selection: $station) {
                                
                                ForEach(TKL_stations, id: \.self) {
                                    
                                    Text($0)
                                    
                                }
                                
                            }
                            
                            .pickerStyle(.menu)
                            
                        }
                        
                        if line == "EAL"{
                            
                            Picker("Station", selection: $station) {
                                
                                ForEach(EAL_stations, id: \.self) {
                                    
                                    Text($0)
                                    
                                }
                                
                            }
                            
                            .pickerStyle(.menu)
                            
                        }
                        
                        if line == "SIL"{
                            
                            Picker("Station", selection: $station) {
                                
                                ForEach(SIL_stations, id: \.self) {
                                    
                                    Text($0)
                                    
                                }
                                
                            }
                            
                            .pickerStyle(.menu)
                            
                        }
                        
                        if line == "TWL"{
                            
                            Picker("Station", selection: $station) {
                                
                                ForEach(TWL_stations, id: \.self) {
                                    
                                    Text($0)
                                    
                                }
                                
                            }
                            
                            .pickerStyle(.menu)
                            
                        }
                        
                        if line == "ISL"{
                            
                            Picker("Station", selection: $station) {
                                
                                ForEach(ISL_stations, id: \.self) {
                                    
                                    Text($0)
                                    
                                }
                                
                            }
                            
                            .pickerStyle(.menu)
                            
                        }
                        
                        if line == "KTL"{
                            
                            Picker("Station", selection: $station) {
                                
                                ForEach(KTL_stations, id: \.self) {
                                    
                                    Text($0)
                                    
                                }
                                
                            }
                            
                            .pickerStyle(.menu)
                            
                        }
                        
                    }
                    
                    .padding(.trailing)
                    
                }
                
                Divider()
                
                VStack {
                    
                    Button{
                        
                        StartJourney = true
                        
                    }label:{
                        
                        HStack{
                            
                            Image(systemName: "train.side.front.car")
                            
                            Text("Start")
                            
                        }
                        
                    }
                    
                    .buttonStyle(.borderedProminent)
                    
                }
                
                .padding()
                
                if StartJourney {
                    
                    Text("Tracking your journey for any potential falls. If detected, we will notify your emergency contacts.")
                    
                    HStack{
                        
                        Text("To end, click here ->")
                        
                        Button{
                            
                            StartJourney = false
                            
                        }label:{
                            
                            Text("End")
                            
                        }
                        
                        .buttonStyle(.bordered)
                        
                    }
                    
                    //MARK: - Fall Detection
                    
                    if let accelerator_Data = journeyMotionManager.accelerometerData, let gyro_Data = journeyMotionManager.gyroData, let location_data = journeyLocationManager.location{
                        
                        let a_x = accelerator_Data.acceleration.x
                        
                        let a_y = accelerator_Data.acceleration.z
                        
                        let a_z = accelerator_Data.acceleration.z
                        
                        let acc = sqrt(pow(a_x,2)+pow(a_y,2)+pow(a_z,2))
                        
                        let falldidhappen = checkFall(accelerator_Data.acceleration, gyro_Data.rotationRate, acc)
                        
                        if falldidhappen{
                            
                            let acc_x = accelerator_Data.acceleration.x
                            
                            let acc_y = accelerator_Data.acceleration.z
                            
                            let acc_z = accelerator_Data.acceleration.z
                            
                            let acc = sqrt(pow(acc_x,2)+pow(acc_y,2)+pow(acc_z,2))
                            
                            let gyro_x = gyro_Data.rotationRate.x
                            
                            let gyro_y = gyro_Data.rotationRate.y
                            
                            let gyro_z = gyro_Data.rotationRate.z
                            
                            let gyro = sqrt(pow(gyro_x,2)+pow(gyro_y,2)+pow(gyro_z,2))
                            
                            let _ = uploadFallData(didfallhappen: "\(falldidhappen)", datetimeadded: "\(getTime())", latitude: "\(String(describing: location_data.latitude))", longitude: "\(String(describing: location_data.longitude))", selected_line: "\(line)", selected_station: "\(station)", acc: "\(acc)", gyro: "\(gyro)")
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        .navigationTitle("Track Journey")
        
        .onAppear(){
            
            journeyMotionManager.startGyroUpdates()
            
            journeyMotionManager.startAccelerometerUpdates()
            
        }
        
    }
    
    func getTime() -> String {
        
        let formatter = DateFormatter()
        
        formatter.timeStyle = .long
        
        formatter.dateStyle = .long
        
        let dateString = formatter.string(from: Date())
        
        return dateString
        
    }
    
    func uploadFallData(didfallhappen: String, datetimeadded: String, latitude: String, longitude: String, selected_line: String, selected_station: String, acc: String, gyro: String){
        
        let db = Firestore.firestore()
        
        db.collection("Fall Detected").document().setData([
            
            "fall_detected": didfallhappen,
            
            "latitude": latitude,
            
            "longitude": longitude,
            
            "line": line,
            
            "station": station,
            
            "date_time_added": datetimeadded,
            
            "accleration_after_fall": acc,
            
            "rotation_rate_after_fall": gyro,
            
            "notified": false
            
        ], merge: true) { error in
            
            if let error = error {
                
                print("Error writing document: \(error)")
                
            } else {
                
                print("Document successfully written!")
                
            }
            
        }
        
    }
    
    func checkFall(_ acc: CMAcceleration, _ gyro: CMRotationRate, _ initial_acc: Double)->Bool{
        
        let lft_acc = 0.3 // Experimental Value = 0.3 g
        
        let uft_acc = 0.001 // Experimental Value = 2.4 g
        
        let uft_gyro:Double = 2.0 // Experimental Value = 240 degrees/sec or 4.18879 radians/sec
        
        
        
        if initial_acc < lft_acc{
            
            let _ = Thread.sleep(forTimeInterval: 3) // Experimental Value = 0.5 seconds
            
            let new_a_x = acc.x
            
            let new_a_y = acc.z
            
            let new_a_z = acc.z
            
            let g_x = gyro.x
            
            let g_y = gyro.y
            
            let g_z = gyro.z
            
            let new_acc = sqrt(pow(new_a_x,2)+pow(new_a_y,2)+pow(new_a_z,2))
            
            let angular_velocity = sqrt(pow(g_x,2)+pow(g_y,2)+pow(g_z,2))
            
            if (new_acc > uft_acc), (angular_velocity > uft_gyro){
                
                let _ = print("Fall Detected")
                
                isThereAFall = true
                
                return true
                
            }
            
        }
        
        return false
        
    }
    
}



