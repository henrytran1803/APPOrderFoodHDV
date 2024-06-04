//
//  ContentView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 08/05/2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager.shared
    @State private var search: String = ""
    @StateObject private var vm = SearchResultsViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                List(vm.places) { place in
                    Text(place.name)
                }
                
            }.searchable(text: $vm.searchText)
              
                .navigationTitle("Places")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
