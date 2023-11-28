//
//  MapPageView.swift
//  data_collector
//
//  Created by Naman Arora on 27/11/2023.
//

import SwiftUI
import MapKit


struct MapPageView: View {
    
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 53.3373689, longitude: -6.2840002), span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    @StateObject var mapManager = MapManager()
    var body: some View {

    Map(coordinateRegion: $mapManager.region_when_launch, interactionModes: .all, showsUserLocation: true)
            .navigationTitle("Map")
            .mapStyle(.standard(elevation: .realistic))
            .edgesIgnoringSafeArea(.all)
    }
}
