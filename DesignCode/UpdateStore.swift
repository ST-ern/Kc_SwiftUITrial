//
//  UpdateStore.swift
//  DesignCode
//
//  Created by c happy on 2020/3/13.
//  Copyright © 2020 c happy. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
    @Published var updates: [Update] = []
    
    init(updates: [Update] = []) {
        self.updates = updates
    }
}
