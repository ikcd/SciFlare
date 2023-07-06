//
//  mapView.swift
//  Sciflare
//
//  Created by KCD on 05/07/23.
//

import SwiftUI
import MapKit

struct mapView: View {
    @StateObject var manager = locationService()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
        Map(coordinateRegion: $manager.region,  showsUserLocation: true)
    }
}

struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        mapView()
    }
}
