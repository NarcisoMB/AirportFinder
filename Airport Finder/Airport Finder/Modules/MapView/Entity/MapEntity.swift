//  MapEntity.swift
//  Airport Finder
//  Created by Narciso Meza on 30/10/23.

import MapKit

struct Location: Identifiable {
	let id = UUID()
	let name: String
	var coordinate: CLLocationCoordinate2D
}
