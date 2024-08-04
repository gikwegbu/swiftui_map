//
//  swiftui_mapApp.swift
//  swiftui_map
//
//  Created by gikwegbu on 02/08/2024.
//

import SwiftUI

@main
struct swiftui_mapApp: App {
	@StateObject private var vm = LocationsViewModel()
   
	var body: some Scene {
        WindowGroup {
            LocationsView()
						.environmentObject(vm)
        }
    }
}
