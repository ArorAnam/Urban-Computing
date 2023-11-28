//
//  TrainView.swift
//  data_collector
//
//  Created by Naman Arora on 27/11/2023.
//

import SwiftUI
import Firebase



struct TrainView: View {
    
    
    
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
    
    @State private var line_station = ""
    
    @State var isGetInfoPressed = false
    
    @State var dataFromFirestore:[String: Any] = ["": ""]
    
    
    
    
    
    var body: some View {
        
        VStack{
            
            ScrollView{
                
                HStack{
                    
                    HStack{
                        
                        Text("Line:")
                        
                            .font(.headline)
                        
                            .fontWeight(.semibold)
                        
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
                    
                }
                
                .padding()
                
                Divider()
                
                Button{
                    
                    isGetInfoPressed.toggle()
                    
                    let db = Firestore.firestore()
                    
                    line_station = "\(line)-\(station)"
                    
                    let docRef = db.collection("Train_Arrival_Info").document(line_station)
                    
                    let _ = docRef.getDocument { (document, error) in
                        
                        guard error == nil else {
                            
                            print("error", error ?? "")
                            
                            return
                            
                        }
                        
                        if let document = document, document.exists {
                            
                            let data = document.data()
                            
                            if let data = data {
                                
                                dataFromFirestore = data
                                
                            }
                            
                        }
                        
                    }
                    
                }label:{
                    
                    Image(systemName: "info.circle.fill")
                    
                    Text("Get Info")
                    
                }
                
                .buttonStyle(.borderedProminent)
                
                if isGetInfoPressed{
                    
                    if let dataDataFromFirestore = dataFromFirestore["data"], let isdelayDataFromFirestore = dataFromFirestore["isdelay"]{
                        
                        Text("\(String(describing: dataDataFromFirestore))")
                        
                        Text("Is train delayed? \(String(describing: isdelayDataFromFirestore))")
                        
                            .font(.headline)
                        
                            .fontWeight(.semibold)
                        
                    }
                    
                    Text("Finish")
                    
                        .font(.headline)
                    
                        .fontWeight(.bold)
                    
                }
                
            }
            
        }
        
        .navigationTitle("Trains")
        
    }
    
}
