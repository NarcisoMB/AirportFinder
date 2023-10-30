//  HostViewUI.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import SwiftUI
import MapKit

fileprivate struct Constants {
	static var map = "map.circle"
	static var location = "location"
	static var airport = "airplane.circle"
	static var coordinates = LocationManager().locationManager.location?.coordinate
}


struct HostViewUI: View {
	@EnvironmentObject private var aviationDataGateway: AviationDataGateway
	
	@State private var annotations: [Location] = []
	@State private var manager = LocationManager() {
		didSet {
			print(manager.region)
		}
	}
	
	@State private var viewSelection = 0
	
	@Binding var distance: Double
	
	var body: some View {
		ZStack {
			if viewSelection == 0 {
				MapViewUI(manager: $manager, annotations: $annotations, hostView: self)
			} else if viewSelection == 1 {
				AirportListViewUI(viewSelection: $viewSelection, annotations: $annotations, manager: $manager, hostView: self)
			}
			VStack {
				Spacer()
				HStack {
					Spacer()
					Button(action: {
						withAnimation {
							let manager = LocationManager()
							if let location = manager.locationManager.location {
								manager.region = MKCoordinateRegion(
									center: location.coordinate,
									span: MKCoordinateSpan(
										latitudeDelta: 1,
										longitudeDelta: 1
									)
								)
								focusAnnotation(manager)
							}
						}
					}, label: {
						Image(systemName: Constants.location)
							.background() {
								Circle()
									.fill(.gray)
									.frame(width: 32, height: 32)
							}
					})
					.padding([.bottom, .trailing])
				}
				Picker("", selection: $viewSelection) {
					Image(systemName: Constants.map).tag(0)
					Image(systemName: Constants.airport).tag(1)
				}
				.frame(height: 48)
				.pickerStyle(.segmented)
				.padding(.all)
				.background() {
					RoundedRectangle(cornerRadius: 12)
						.fill(.gray)
				}
				.padding(.bottom, -32)
			}
		}
		.task {
			withAnimation {
				if let lat = Constants.coordinates?.latitude, let lng = Constants.coordinates?.longitude {
					let dto = AviationDataRequest(
						lat: "\(Int(lat))",
						lon: "\(Int(lng))",
						radius: "\(Int(distance))"
					)
					aviationDataGateway.nearbyAirports(dto) { result in
						annotations = result.map{ $0.toLocation() }
						if let coordinate = annotations.first?.coordinate {
							let manager = LocationManager()
							manager.region = MKCoordinateRegion(
								center: coordinate,
								span: MKCoordinateSpan(
									latitudeDelta: 1,
									longitudeDelta: 1
								)
							)
							focusAnnotation(manager)
						}
					}
				}
			}
		}
	}
	
	func focusAnnotation(_ newManager: LocationManager) {
		self.manager = newManager
	}
}

#Preview {
	HostViewUI(distance: .constant(10))
}
