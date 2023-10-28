//  MapViewUI.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import SwiftUI
import MapKit

struct MapViewUI: View {
	@StateObject var manager = LocationManager()
	
	@Binding var annotations: [Location]
	
	var body: some View {
		Map(coordinateRegion: $manager.region,
			interactionModes: .all,
			showsUserLocation: true,
			userTrackingMode: .constant(.follow),
			annotationItems: $annotations
		) { place in
			MapPin(coordinate: place.coordinate.wrappedValue)
		}
		.ignoresSafeArea()
		.navigationBarHidden(true)
	}
}

#Preview {
	MapViewUI(annotations: .constant([Location(name: "1", coordinate: CLLocationCoordinate2D(latitude: 20.703444, longitude: -101.368224))]))
}

struct Location: Identifiable {
	let id = UUID()
	let name: String
	var coordinate: CLLocationCoordinate2D
}
