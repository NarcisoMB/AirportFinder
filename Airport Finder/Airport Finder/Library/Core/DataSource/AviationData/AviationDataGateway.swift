//  AviationDataGateway.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import Foundation

class AviationDataGateway: ObservableObject {
	func nearbyAirports(_ dto: AviationDataRequest, completion: @escaping ([AirportInformation]) -> Void) {
		let headers = [
			"X-RapidAPI-Key": "896f18150dmshb8df0aa44dd3d6cp1cb854jsnb8e2ee326ed5",
			"X-RapidAPI-Host": "aviation-reference-data.p.rapidapi.com"
		]
		
		let request = NSMutableURLRequest(
			url: NSURL(string: "https://aviation-reference-data.p.rapidapi.com/airports/search?lat=\(dto.lat)&lon=\(dto.lon)&radius=\(dto.radius)")! as URL,
			cachePolicy: .useProtocolCachePolicy,
			timeoutInterval: 10.0
		)
		
		request.httpMethod = "GET"
		request.allHTTPHeaderFields = headers
		
		let session = URLSession.shared
		let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
			if (error != nil) {
				print(error as Any)
			} else {
				do {
					guard let data = data else { return }
					let result = try JSONDecoder().decode([AirportInformation].self, from: data)
					completion(result)
					return
				} catch {
					print(error)
				}
			}
		})
		
		dataTask.resume()
	}
}
