//  AirportListViewUI.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import SwiftUI
import MapKit

fileprivate struct Constants {
	static var navTitle = "Airport list near you"
}

struct AirportListViewUI: View {
	@Binding var viewSelection: Int
	@Binding var annotations: [Location]
	@Binding var manager: LocationManager
	
	var hostView: HostViewUI
	
    var body: some View {
		VStack {
			List {
				ForEach(annotations, id: \.name) { airport in
					Text(airport.name)
						.onTapGesture {
							let manager = LocationManager()
							manager.region = MKCoordinateRegion(
								center: airport.coordinate,
								span: MKCoordinateSpan(
									latitudeDelta: 1,
									longitudeDelta: 1
								)
							)
							hostView.focusAnnotation(manager)
							viewSelection = 0
						}
				}
			}
			.padding(.top)
		}
		.navigationBarBackButtonHidden(true)
		.navigationTitle(Constants.navTitle)
    }
}

#Preview {
	AirportListViewUI(viewSelection: .constant(0), annotations: .constant([Location(name: "1", coordinate: CLLocationCoordinate2D(latitude: 20.703444, longitude: -101.368224))]), manager: .constant(LocationManager()), hostView: HostViewUI(distance: .constant(1)))
}
