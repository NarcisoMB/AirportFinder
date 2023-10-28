//  AviationDataResponse.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import MapKit

struct AviationDataResponse: Codable {
	var airportsNearby: [AirportInformation]
	
}

struct AirportInformation: Codable {
	var alpha2countryCode: String
	var iataCode: String?
	var icaoCode: String?
	var latitude: Double
	var longitude: Double
	var name: String

	init(alpha2countryCode: String, iataCode: String, icaoCode: String, latitude: Double, longitude: Double, name: String) {
		self.alpha2countryCode = alpha2countryCode
		self.iataCode = iataCode
		self.icaoCode = icaoCode
		self.latitude = latitude
		self.longitude = longitude
		self.name = name
	}
	
	enum CodingKeys: String, CodingKey {
		case alpha2countryCode =  "alpha2countryCode"
		case iataCode =  "iataCode"
		case icaoCode =  "icaoCode"
		case latitude =  "latitude"
		case longitude =  "longitude"
		case name =  "name"
	}
	
	func toLocation() -> Location {
		return Location(name: self.name, coordinate: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude))
	}
}
