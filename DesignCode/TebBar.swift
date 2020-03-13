//
//  TebBar.swift
//  DesignCode
//
//  Created by c happy on 2020/3/12.
//  Copyright © 2020 c happy. All rights reserved.
//

import SwiftUI

struct TebBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image("IconHome")
                Text("Home")
            }
            .tag(1)
            ContentView().tabItem {
                Image("IconCards")
                Text("Certificate")
            }
            .tag(2)
            Settings().tabItem {
                Image("IconSettings")
                Text("Settings")
            }
            .tag(3)
        }
    }
}

struct TebBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TebBar()
            TebBar()
                .environment(\.colorScheme, .dark)
                .environment(\.sizeCategory, .extraLarge)
        }
    }
}
