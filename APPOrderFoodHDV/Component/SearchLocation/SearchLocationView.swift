//
//  SearchLocationView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 12/05/2024.
//

import SwiftUI
import Combine
struct SearchLocationView: View {
    @Binding var signupmodel: SignUpViewModel
    @StateObject private var locationManager = LocationManager.shared
    @State private var search: String = ""
    @StateObject private var vm = SearchResultsViewModel()
    @Binding var isOpenLocation: Bool
    var body: some View {
        
        NavigationView {
            VStack {
                List(vm.places) { place in
                    Text(place.name)
                        .onTapGesture {
                            signupmodel.signup.address = place.name
                            isOpenLocation.toggle()
                        }
                }
                
            }.searchable(text: $vm.searchText)
              
                .navigationTitle("Địa điểm")
        }
    }}

//#Preview {
//    SearchLocationView(address: .constant(""), isOpenLocation: .constant(true))
//}
