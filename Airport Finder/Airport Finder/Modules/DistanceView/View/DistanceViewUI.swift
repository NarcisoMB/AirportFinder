//  DistanceViewUI.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import SwiftUI

struct DistanceViewUI: View {
	@State private var distance: Double = 0
	
    var body: some View {
		NavigationView{
			VStack(spacing: 24) {
				Text("Airport".uppercased())
					.font(.system(size: 42))
					.bold()
				Text("finder")
					.font(.system(size: 32))
				Spacer()
					.frame(height: 120)
				Text("\(distance, specifier: "%.0f")")
					.font(.system(size: 42))
				Slider(value: $distance, in: 0...500)
					.padding(.horizontal, 16)
				Text("Radious in km".uppercased())
				Spacer()
					.frame(height: 120)
				NavigationLink(destination: {
					HostViewUI(distance: $distance)
				}, label: {
					Text("Search")
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
