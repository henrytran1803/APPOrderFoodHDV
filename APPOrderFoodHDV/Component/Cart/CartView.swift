//
//  CartView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 4/6/24.
//

import SwiftUI

struct CartView: View {
    @State var codeDiscount = ""
    @State var percentDiscount : Double = 0
    @State var isDisscount = false
    @State var isDiscountShown = false
    @State var disount = ""
    @State var isCheckout = false
    @State var percent : Double = 0
    @State var total: Double = 0
    @State var order :Order = Order(id: 1, orderDesc: "", orderFee: 0, userId: 0, orderDetails: [])
    @StateObject private var cartItemModel = CartItemViewModel()
    @ObservedObject private var productlist = ProductListsViewModel()
    var body: some View {
        VStack{
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("My")
                                .font(.system(size: 20))
                            Text("Cart list")
                                .font(.system(size: 25))
                        }.bold()
                        Spacer()
                    }.padding([.top, .leading], 50)
                    List {
                        ForEach($cartItemModel.items, id: \.id) { item in
                            if let product = productlist.products.first(where: { $0.id == item.id }) {
                                ItemCartView(product: product,quantity: item.quantity, cartItemModel: cartItemModel)
                            }
                        }
                        .onDelete(perform: removeRows)
                    }
                    
                    Button(action: {isDiscountShown = true}, label: {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.white)
                            .frame(width: .infinity, height: 50)
                            .overlay{
                                HStack{
                                    Image(systemName: "umbrella.percent.fill")
                                        .foregroundColor(Color.green)
                                        .font(.system(size: 20))
                                        .padding(.horizontal)
                                    if codeDiscount.isEmpty {
                                        Text("Bạn có mã giảm giá ư?")
                                            .foregroundColor(.black)
                                            .font(.system(size: 20))
                                    }else {
                                        Text("\(codeDiscount), \(percentDiscount)")
                                            .foregroundColor(.black)
                                            .font(.system(size: 20))
                                    }
                                }
                            }
                    }).padding(.horizontal)
                    BottomCartView(totalall: totalAll, discount: $percentDiscount, isCheckout: $isCheckout)
                    
                }
                .ignoresSafeArea()
                .background(Color("bgcart"))
                .onAppear{
                    productlist.fetchProducts(items: cartItemModel.items)
                }
            
        }.sheet(isPresented: $isCheckout, content: {
            let id = UserDefaults.standard.integer(forKey: "id_user")
            let total = totalAll()
            let order = OrderCreate(orderDesc: "", orderFee: total, userId: id, orderDetails: cartItemModel.items)
            MainPayment(order: order)
                .presentationDetents([.height(600)])

        })
    }
    private func updatePercent() {
        print("\(percentDiscount)    \(total)")
        percent = (percentDiscount * total) / 100
    }
    private func removeRows(at offsets: IndexSet) {
        offsets.forEach { index in
            let item = cartItemModel.items[index]
            if let productIndex = productlist.products.firstIndex(where: { $0.id == item.id }) {
                cartItemModel.removeItem(productlist.products[productIndex])
                productlist.products.remove(at: productIndex)
            }
        }
    }
//    products.remove(atOffsets: offsets)
//}
//    private func payment() -> Oder{
//
//        let user = InfoUser()
//        user.fetchUser()
//        let order : Oder = Oder(name: "", adress: "", total: total, discount: percentDiscount, date: Timestamp(date: Date()), products: products, status: .no, payment: .cash)
//        print(order)
//        return order
//    }
    func totalAll() -> Double {
        var total = 0.0
        for item in cartItemModel.items {
            if let product = productlist.products.first(where: { $0.id == item.id }) {
                total += product.price * Double(item.quantity)
            }
        }
        return total
    }
    func fetchProduct(byID id: String, completion: @escaping (Product?) -> Void) {
        let url = URL(string: "https://127.0.0.1:8081/products/\(id)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let product = try? JSONDecoder().decode(Product.self, from: data)
            completion(product)
        }.resume()
    }
}


