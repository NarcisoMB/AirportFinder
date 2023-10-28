//  ContentView.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import SwiftUI

fileprivate struct Constants {
	static var screenDim = UIScreen.main.bounds
}

struct ContentView: View {
	@State private var distance: Double = 0

	var body: some View {
		NavigationView{
			DistanceViewUI()
				.environmentObject(AviationDataGateway())
		}
	}
}

#Preview {
	ContentView()
}
