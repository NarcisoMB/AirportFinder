//  AviationDataEndpoint.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import Foundation

enum AviationDataEndpoint {
	case nearbyAirports
	var asURL: URL {
		get throws {
			var endpoint: URL?
			switch self {
			case .nearbyAirports:
				endpoint = URL(string: "https://aviation-reference-data.p.rapidapi.com/airports/search")
			}
			return endpoint!
		}
	}
}
