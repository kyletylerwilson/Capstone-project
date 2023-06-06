//
//  Menu.swift
//  LittleLemon
//
//  Created by Kyle Wilson on 2023-05-30.
//

import SwiftUI

struct Menu: View {
    
    @State var searchText = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let data = data {
                    if let menu = try? JSONDecoder().decode(MenuList.self, from: data) {
                        menu.menu.forEach { menu in 
                            let dish = Dish(context: viewContext)
                            dish.title = menu.title
                            dish.image = menu.image
                            dish.price = menu.price
                            dish.descript = menu.description
                        }
                        try? viewContext.save()
                    }
                }
            }
        }
        task.resume()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .padding(.leading, 45)
                Image("Profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
            }
            ZStack {
                Rectangle()
                    .foregroundColor(Color("Hero-Background"))
                    .cornerRadius(25)
                VStack(alignment: .leading) {
                    Text("Little Lemon")
                        .foregroundColor(Color("Little-Lemon"))
                        .font(.largeTitle)
                        .bold()
                    Text("Chicago")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                    HStack {
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .foregroundColor(.white)
                            .bold()
                            .font(.system(size: 14))
                        Spacer()
                        Image("Hero image")
                            .resizable()
                            .frame(width: 110)
                            .scaledToFit()
                            .cornerRadius(20)
                    }
                    HStack(spacing: 10) {
                        Button {
                            print("focus textfield")
                        } label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                        }

                        TextField("Search menu", text: $searchText)
                            .colorInvert()
                    }
                }
                .padding()
            }
            OrderForDeveliveryMenuView()
                .padding(.top, 10)
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()){ (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(dish.title!)
                                .bold()
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(dish.descript!)
                                        .font(.system(size: 13))
                                    Text("$\(dish.price!).00")
                                        .bold()
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                AsyncImage(url: URL(string: dish.image!)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80)
                                } placeholder: {
                                    EmptyView()
                                        .frame(width: 80)
                                }
                            }
                        }
                    }
                }
            }
        }.padding()
        .onAppear {
            getMenuData()
        }
    }
}

struct OrderForDeveliveryMenuView: View {
    
    let foodOptions = ["Starters", "Main", "Desserts", "Drinks"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order for Delivery!")
                .textCase(.uppercase)
                .bold()
                .padding(.leading, 5)
            HStack(spacing: 10) {
                ForEach(foodOptions, id: \.self) { option in
                    Text(option)
                        .foregroundColor(Color("Hero-Background"))
                        .font(.system(size: 15))
                        .bold()
                        .frame(width: 85, height: 35)
                        .background(Color("Hero-Background").opacity(0.2))
                        .cornerRadius(20)
                        
                }
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
