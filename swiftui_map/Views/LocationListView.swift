//
//  LocationListView.swift
//  swiftui_map
//
//  Created by gikwegbu on 03/08/2024.
//

import SwiftUI

struct LocationListView: View {
	@EnvironmentObject  var vm: LocationsViewModel
	
	
    var body: some View {
			List {
				ForEach(vm.locations) { loc in
					locationListRowView(loc: loc)
						.padding(.vertical, 4)
						.onTapGesture {
							vm.updateMapLocation(loc: loc)
						}
						.listRowBackground(Color.clear)
				}
			}
			.listStyle(PlainListStyle())
    }
}

#Preview {
    LocationListView()
		.environmentObject(LocationsViewModel())
}
