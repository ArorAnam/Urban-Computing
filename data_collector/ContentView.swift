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

import Firebase



struct ContentView: View {
    
    
    
    
    
    let menuItems = [
        
        "Map",
        
        "Sensor Data",
        
        "MTR Train Data",
        
        "Track Journey"
        
    ]
    
    let sensorv = SensorView()
    
    
    
    var body: some View {
        
        NavigationStack{
            
            List{
                
                ForEach(menuItems, id: \.self) { item in
                    
                    if item == "MTR Train Data"{
                        
                        NavigationLink(destination: TrainView()){
                            
                            Text(item)
                            
                        }
                        
                    }
                    
                    else if item == "Map"{
                        
                        NavigationLink(destination: MapPageView()){
                            
                            Text(item)
                            
                        }
                        
                    }
                    
                    else if item == "Sensor Data"{
                        
                        NavigationLink(destination: SensorView()){
                            
                            Text(item)
                            
                        }
                        
                    }
                    
                    else if item == "Track Journey"{
                        
                        NavigationLink(destination: JourneyView()){
                            
                            Text(item)
                            
                        }
                        
                    }
                    
                    else{
                        
                        NavigationLink(destination: Text(item)) {
                            
                            Text(item)
                            
                        }
                        
                    }
                    
                    
                    
                }
                
                .navigationTitle("Menu")
                
            }
            
        }
        
    }
    
}
