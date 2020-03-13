//
//  ContentView.swift
//  DesignCode
//
//  Created by c happy on 2020/3/6.
//  Copyright © 2020 c happy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    
    
    var body: some View {
        ZStack {
            
//            HomeList()
            
            BlurView(style: .systemMaterial)
            
            TitleView()
                .blur(radius: show ? 20 : 0)
                .animation(.default)
            
            CardBottomView()
                .blur(radius: show ? 20 : 0)
                .animation(.default)
            
            CardView()
                .background(show ? Color.red : Color("background9"))
                .cornerRadius(10)
                .shadow(radius: 20)
                .scaleEffect(0.85)
                .offset(x:0, y:show ? -400 : -40)
                .rotationEffect(Angle(degrees: show ? 15 : 0))
                //                .rotation3DEffect(Angle(degrees: show ? 30 : 0), axis: /*@START_MENU_TOKEN@*/(x: 10.0, y: 10.0, z: 10.0)/*@END_MENU_TOKEN@*/)
                .blendMode(/*@START_MENU_TOKEN@*/.hardLight/*@END_MENU_TOKEN@*/)
                .animation(.easeInOut(duration : 0.6))
                .offset(x: viewState.width, y: viewState.height)
            
            
            CardView()
                .background(show ? Color.red : Color("background8"))
                .cornerRadius(10)
                .shadow(radius: 20)
                .scaleEffect(0.9)
                .offset(x: 0, y:show ? -200 : -20)
                .rotationEffect(Angle(degrees: show ? 10 : 0))
                //                .rotation3DEffect(Angle(degrees: show ? 30 : 0), axis: /*@START_MENU_TOKEN@*/(x: 10.0, y: 10.0, z: 10.0)/*@END_MENU_TOKEN@*/)
                .blendMode(/*@START_MENU_TOKEN@*/.hardLight/*@END_MENU_TOKEN@*/)
                .animation(.easeInOut(duration : 0.4))
                .offset(x: viewState.width, y: viewState.height)
            
            CertificateView()
                .offset(x: viewState.width, y: viewState.height)
                .scaleEffect(0.95)
                .rotationEffect(Angle(degrees: show ? 5 : 0))
                //                .rotation3DEffect(Angle(degrees: show ? 30 : 0), axis: /*@START_MENU_TOKEN@*/(x: 10.0, y: 10.0, z: 10.0)/*@END_MENU_TOKEN@*/)
                .animation(.spring())
                .onTapGesture {
                    self.show.toggle()
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.viewState = value.translation
                        self.show = true
                }
                .onEnded { value in
                    self.viewState = CGSize.zero
                    self.show = false
                }
            )
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CardView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Card Back"/*@END_MENU_TOKEN@*/)
        }
        .frame(width: 340.0, height: 220.0)
        
    }
}

struct CertificateView: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(/*@START_MENU_TOKEN@*/"UI Design"/*@END_MENU_TOKEN@*/)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.top)
                    Text(/*@START_MENU_TOKEN@*/"Certificate"/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("accent"))
                        .padding(.top)
                    
                }
                Spacer()
                Image("Logo")
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
            }
            .padding(.horizontal)
            Image("Background")
        }
        .frame(width: 340.0, height: 220.0)
        .background(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        .cornerRadius(15)
        .shadow(radius: 20)
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(/*@START_MENU_TOKEN@*/"Certificate"/*@END_MENU_TOKEN@*/)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                }
                Spacer()
            }
            Image("Illustration5")
            Spacer()
        }.padding()
    }
}

struct CardBottomView: View {
    var body: some View {
        VStack(spacing: 20.0) {
            Rectangle()
                .frame(width: 60.0, height: 6.0)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .opacity(0.1)
            
            Text("This certiticate is proof that Duludulu has  achieve the UI design course with approval from a Design+Code instructor.")
                .lineLimit(3)
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .padding(.horizontal)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(30)
        .shadow(radius: 20)
        .offset(y:600)
    }
    
}
