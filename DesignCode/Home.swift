//
//  Home.swift
//  DesignCode
//
//  Created by c happy on 2020/3/9.
//  Copyright © 2020 c happy. All rights reserved.
//

import SwiftUI

struct Home: View {

    @State var show = false
    
    var body: some View {
        ZStack {
            Button(action: {
                self.show.toggle()
            }) {
                Text("Open Menu")
            }
            
            
            MenuView(show: $show)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct MenuRow: View {
    var image = "creditcard"
    var text = "My Account"
    var body: some View {
        HStack {
            Image(systemName: image)
                .frame(width: 32.0, height: 32.0)
                .imageScale(.medium)
                .foregroundColor(Color("icons"))
            Text(text)
                .font(.headline)
            Spacer()
        }
    }
}

struct Menu: Identifiable {
    var id = UUID()
    
    var title: String
    var icon: String
}

let menuDate = [
    Menu(title: "My Account", icon: "person.crop.circle"),
    Menu(title: "Billing", icon: "creditcard"),
    Menu(title: "Team", icon: "person.and.person"),
    Menu(title: "Sign out", icon: "arrow.uturn.down"),
]

struct MenuView: View {
    var menuItems = ["My Account", "Billing", "Team", "Sign out"]
    var menu = menuDate
    @Binding var show: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            
            ForEach(menu) { item in
                MenuRow(image: item.icon, text: item.title)
            }
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(30)
        .frame(minWidth:0, maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
        .padding(.trailing, 60)
        .shadow(radius: 20)
        .rotation3DEffect(Angle(degrees: show ? 0 : 90), axis: (x: 0, y: 10.0, z: 0))
        .animation(.default)
        .offset(x: show ? 0 : -UIScreen.main.bounds.width)
        .onTapGesture {
            self.show.toggle()
        }
    }
}
