//
//  HomeList.swift
//  DesignCode
//
//  Created by c happy on 2020/3/10.
//  Copyright © 2020 c happy. All rights reserved.
//

import SwiftUI

struct HomeList: View {
    var courses = courseData
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Courses")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("22 courses")
                        .foregroundColor(Color.gray)
                }
                Spacer()
            }
            .padding(.leading, 70)
            .padding(.bottom, 40)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30.0) {
                    ForEach(courses) { item in
                        //                        NavigationLink(destination: ContentView()) {
                        //                            CourseView()
                        //                        }
                        CourseView(title: item.title,
                                   image: item.image,
                                   color: item.color,
                                   shadowColor: item.shadowColor
                        )
                    }
                }
                .padding(.bottom, 50)
                .padding(.leading, 30)
            }
            Spacer()
        }
        .padding(.top, 78)
        
    }
}

struct HomeList_Previews: PreviewProvider {
    static var previews: some View {
        HomeList()
    }
}

struct CourseView: View {
    var title = "Build an app with SwiftUI"
    var image = "Illustration1"
    var color = Color("background3")
    var shadowColor = Color("backgroundShadow4")
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(35.0)
                .lineLimit(4)
                .padding(.trailing, 50)
            //                .frame(width: 160.0)
            Spacer()
            Image(image)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 246.0, height: 150.0)
                .padding(.bottom, 30)
        }
        .frame(width: 246.0, height: 360.0)
            
        .background(color)
        .cornerRadius(30)
        .shadow(color: shadowColor, radius: 20, x: 0, y: 20)
    }
}

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var color: Color
    var shadowColor: Color
}

let courseData = [
    Course(title: "Build an app with swidtUI",
           image: "Illustration1",
           color: Color("background3"),
           shadowColor: Color("backgroundShadow4")
    ),
    Course(title: "Design Course",
           image: "Illustration2",
           color: Color("background4"),
           shadowColor: Color("backgroundShadow3")
    )
]
