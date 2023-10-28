//  HostViewUI.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import SwiftUI
import MapKit

fileprivate struct Constants {
	static var map = "map.circle"
	static var airport = "airplane.circle"
	static var coordinates = LocationManager().locationManager.location?.coordinate
}


struct HostViewUI: View {
	
	@EnvironmentObject private var aviationDataGateway: AviationDataGateway
	
	@StateObject var manager = LocationManager()
	
	@State private var favoriteColor = 0
	
	@State var annotations = [
		Location(name: "1", coordinate: CLLocationCoordinate2D(latitude: 20.703444, longitude: -101.368224)),
		Location(name: "2", coordinate: CLLocationCoordinate2D(latitude: 20.7029818, longitude: -101.3771502)),
		Location(name: "3", coordinate: CLLocationCoordinate2D(latitude: 20.6743564, longitude: -101.3821713))
	]
	
	@Binding var distance: Double
	
	var body: some View {
		ZStack {
			if favoriteColor == 0 {
				MapViewUI(annotations: $annotations)
			} else if favoriteColor == 1 {
				AirportListViewUI(annotations: $annotations)
			}
			VStack {
				Spacer()
				Picker("What is your favorite color?", selection: $favoriteColor) {
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
			if let lat = Constants.coordinates?.latitude, let lng = Constants.coordinates?.longitude {
				let dto = AviationDataRequest(
					lat: "\(Int(lat))",
					lon: "\(Int(lng))",
					radius: "\(Int(distance))"
				)
				aviationDataGateway.nearbyAirports(dto) { result in
					annotations = result.map{ $0.toLocation() }
				}
			}
		}
	}
}

#Preview {
	HostViewUI(distance: .constant(10))
}

extension Double {
	func roundToDecimal(_ fractionDigits: Int) -> Double {
		let multiplier = pow(10, Double(fractionDigits))
		return Darwin.round(self * multiplier) / multiplier
	}
}
