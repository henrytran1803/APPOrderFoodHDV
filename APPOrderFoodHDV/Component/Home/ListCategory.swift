//
//  ListCategory.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 4/6/24.
//

import SwiftUI

struct ListCategory: View {
    @Binding var listCategory: [Category]
    @StateObject var viewModel = CategoryListViewModel()
    @State var selectedCategory: Category?
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(viewModel.categories, id: \.name) { category in
                    CategorySmallView(category: category, listCategory: $listCategory)
                        .onTapGesture {
                            
                        }
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
    @Binding var listCategory: [Category]

    var body: some View {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 150, height: 45)
                .foregroundColor(isClick ? Color.white : Color("bgproduct"))
                .overlay {
                    HStack {
                        Text(category.name)
                            .foregroundColor(isClick ? .black : .white)
                            .bold()
                    }
                }
        
        .buttonStyle(PlainButtonStyle())
        .onTapGesture {
            toggleCategorySelection(category: category)
            self.isClick.toggle()
        }
    }
    private func toggleCategorySelection(category: Category) {
        if let index = listCategory.firstIndex(of: category) {
            listCategory.remove(at: index)
        } else {
            listCategory.append(category)
        }
        print("\(listCategory)")
    }
}



