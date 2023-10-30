//  AirportListViewUI.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import SwiftUI
import MapKit

struct AirportListViewUI: View {
	@Binding var viewSelection: Int
	@Binding var annotations: [Location]
	@Binding var manager: LocationManager
	
    var body: some View {
		VStack {
			List {
				ForEach(annotations, id: \.name) { airport in
					Text(airport.name)
						.onTapGesture {
							viewSelection = 0
							let region = MKCoordinateRegion(center: airport.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
							$manager.region = region

						}
				}
			}
			.padding(.top)
		}
		.navigationBarBackButtonHidden(true)
		.navigationTitle("Airport list near you")
    }
}

#Preview {
	AirportListViewUI(annotations: .constant([Location(name: "1", coordinate: CLLocationCoordinate2D(latitude: 20.703444, longitude: -101.368224))]), viewSelection: .constant(0))
}
