//  SegmentedControl.swift
//  Airport Finder
//  Created by Narciso Meza on 27/10/23.

import SwiftUI

extension UISegmentedControl {
	override open func didMoveToSuperview() {
		super.didMoveToSuperview()
		self.setContentHuggingPriority(.defaultLow, for: .vertical)  // << here !!
	}
}
