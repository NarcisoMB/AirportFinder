//
//  Airport_FinderApp.swift
//  Airport Finder
//
//  Created by Narciso Meza on 27/10/23.
//

import SwiftUI

@main
struct Airport_FinderApp: App {
	@State private var isNavigationBarHidden: Bool = true

    var body: some Scene {
        WindowGroup {
			NavigationView{
				DistanceViewUI()
					.environmentObject(AviationDataGateway())
					.navigationBarTitle("")
					.navigationBarHidden(self.isNavigationBarHidden)
					.onAppear {
						self.isNavigationBarHidden = true
					}
			}
        }
    }
}
