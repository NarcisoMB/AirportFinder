//  DistanceViewUI.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import SwiftUI

fileprivate struct Constants {
	static var airport = "airport"
	static var finder = "finder"
	static var radious = "Radious in km"
	static var search = "Search"
	static var backgroundDistance = "backgroundDistance"
}

struct DistanceViewUI: View {
	@State private var distance: Double = 0
	
	var body: some View {
		ZStack {
			Image(Constants.backgroundDistance)
				.resizable()
				.brightness(-0.2)
			VStack(spacing: 24) {
				Text(Constants.airport.uppercased())
					.font(.system(size: 42))
					.bold()
				Text(Constants.finder)
					.font(.system(size: 32))
				Spacer()
					.frame(height: 120)
				Text("\(distance, specifier: "%.0f")")
					.font(.system(size: 42))
				Slider(value: $distance, in: 0...500)
					.padding(.horizontal, 32)
				Text(Constants.radious.uppercased())
				Spacer()
					.frame(height: 120)
				NavigationLink(destination: {
					HostViewUI(distance: $distance)
						.environmentObject(AviationDataGateway())
				}, label: {
					Text(Constants.search)
						.foregroundColor(.white)
						.padding(.vertical)
						.padding(.horizontal, 120)
						.background(.blue)
						.cornerRadius(10)
				})
			}
		}
	}
}

#Preview {
	DistanceViewUI()
}
