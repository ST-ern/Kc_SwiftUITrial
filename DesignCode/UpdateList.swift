//
//  UpdateList.swift
//  DesignCode
//
//  Created by c happy on 2020/3/10.
//  Copyright © 2020 c happy. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    var updates = updateDate //static value
    @ObservedObject var store = UpdateStore(updates: updateDate) // dynamic value
    
    
    func addUpdate() {
        store.updates.append(Update(image: "Certificate1", title: "New Title", text: "New Text", date: "JUN 1"))
    }
    
    func move(from source: IndexSet, to destination: Int) {
        #warning("not use swap!!! crash!!!")
        store.updates.move(fromOffsets: source, toOffset: destination)
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: addUpdate) {
                    Text("Add Update")
                }
                
                List {
                    ForEach(store.updates) { item in
                        NavigationLink(destination: UpdateDetail(title: item.title,
                                                                 text: item.text,
                                                                 image: item.image)) {
                            HStack(spacing: 12.0) {
                                Image(item.image)
                                .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80.0, height: 80.0)
                                .background(Color("background"))
                                .cornerRadius(20)
                                
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.headline)
                                    Text(item.text)
                                        .font(.subheadline)
                                        .lineLimit(2)
                                        .frame(height: 50.0)
                                        .lineSpacing(4)
                                    Text(item.date)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.gray)
                                }
                            }
                        }
                        .padding(.vertical, 8.0)
                        
                    }
                    .onDelete { indexSet in
                        self.store.updates.remove(at: indexSet.first!)
                    }
                    .onMove(perform: move)
                }
                .navigationBarTitle(Text("Updates"))
                .navigationBarItems(trailing:
                    EditButton()
                )
            }
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

let updateDate = [
    Update(image: "Illustration1", title: "swiftui", text: "大家忽视覅偶尔回复而韩国is的hi多少个is多个收到货IGis个his读后感is多个hi韩国ID深V出魔抗VBUI欧盟是的归属感就是 属地化工is多个hi是个 是个hi第三帝国会死哦低功耗is电话公司工会", date: "JUN 26"),
    Update(image: "Illustration2", title: "swiftui", text: "大家忽视覅偶尔回复而韩国is的hi多少个is多个收到货IGis个his读后感is多个hi韩国ID深V出魔抗VBUI欧盟是的归属感就是 属地化工is多个hi是个 是个hi第三帝国会死哦低功耗is电话公司工会", date: "JUN 26"),
    Update(image: "Illustration3", title: "swiftui", text: "大家忽视覅偶尔回复而韩国is的hi多少个is多个收到货IGis个his读后感is多个hi韩国ID深V出魔抗VBUI欧盟是的归属感就是 属地化工is多个hi是个 是个hi第三帝国会死哦低功耗is电话公司工会", date: "JUN 26"),
    Update(image: "Illustration4", title: "swiftui", text: "大家忽视覅偶尔回复而韩国is的hi多少个is多个收到货IGis个his读后感is多个hi韩国ID深V出魔抗VBUI欧盟是的归属感就是 属地化工is多个hi是个 是个hi第三帝国会死哦低功耗is电话公司工会", date: "JUN 26"),
    Update(image: "Certificate1", title: "swiftui", text: "大家忽视覅偶尔回复而韩国is的hi多少个is多个收到货IGis个his读后感is多个hi韩国ID深V出魔抗VBUI欧盟是的归属感就是 属地化工is多个hi是个 是个hi第三帝国会死哦低功耗is电话公司工会", date: "JUN 26"),
    Update(image: "Certificate2", title: "swiftui", text: "大家忽视覅偶尔回复而韩国is的hi多少个is多个收到货IGis个his读后感is多个hi韩国ID深V出魔抗VBUI欧盟是的归属感就是 属地化工is多个hi是个 是个hi第三帝国会死哦低功耗is电话公司工会", date: "JUN 26"),
    Update(image: "Certificate3", title: "swiftui", text: "大家忽视覅偶尔回复而韩国is的hi多少个is多个收到货IGis个his读后感is多个hi韩国ID深V出魔抗VBUI欧盟是的归属感就是 属地化工is多个hi是个 是个hi第三帝国会死哦低功耗is电话公司工会", date: "JUN 26"),
]


