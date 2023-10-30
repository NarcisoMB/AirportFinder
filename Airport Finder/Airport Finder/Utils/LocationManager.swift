//  LocationManager.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import MapKit

final class LocationManager: NSObject, ObservableObject {
	let locationManager = CLLocationManager()
	
	@Published var region = MKCoordinateRegion(
		center: .init(latitude: 37.334, longitude: -122.009),
		span: .init(latitudeDelta: 2, longitudeDelta: 2)
	)
	
	override init() {
		super.init()
		self.locationManager.delegate = self
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.setup()
	}
	
	func setup() {
		switch locationManager.authorizationStatus {
		case .authorizedWhenInUse:
			locationManager.requestLocation()
		case .notDetermined:
			locationManager.startUpdatingLocation()
			locationManager.requestWhenInUseAuthorization()
		default:
			break
		}
	}
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		guard .authorizedWhenInUse == manager.authorizationStatus else { return }
		locationManager.requestLocation()
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Something went wrong: \(error)")
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		locationManager.stopUpdatingLocation()
		locations.last.map {
			region = MKCoordinateRegion(
				center: $0.coordinate,
				span: .init(latitudeDelta: 2, longitudeDelta: 2)
			)
		}
	}
}
