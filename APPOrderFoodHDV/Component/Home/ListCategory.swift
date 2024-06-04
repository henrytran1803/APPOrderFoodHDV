//
//  ListCategory.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 4/6/24.
//

import SwiftUI

struct ListCategory: View {
    @StateObject var viewModel = CategoryListViewModel()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(viewModel.categories, id: \.name) { category in
                    CategorySmallView(category: category)
//                        .onTapGesture {
//                            self.selectedCategory = category
//                        }
//                        .background(
//                            RoundedRectangle(cornerRadius: 10)
//                                .foregroundColor(category == selectedCategory ? .blue : .clear)
//                        )
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.fetchCategories()
        }
    }
}

struct CategorySmallView: View {
    var category: Category
    @State var isClick = false
    
    var body: some View {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 150, height: 45)
                .foregroundColor(isClick ? Color("bgcategory") : Color("bgproduct"))
                .overlay {
                    HStack {

                        
                        Text(category.name)
                            .foregroundColor(isClick ? .black : .white)
                            .bold()
                    }
                }
        
        .buttonStyle(PlainButtonStyle())
        .onTapGesture {
            self.isClick.toggle()
        }
    }
}


#Preview {
    ListCategory()
}
