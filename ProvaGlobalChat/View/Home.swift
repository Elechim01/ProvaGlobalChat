//
//  Home.swift
//  ProvaGlobalChat
//
//  Created by Michele on 31/12/20.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeModel()
    @AppStorage("current_user") var user = ""
    @State var scrolled = false
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Text("Global Chat")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(Color.green)
            ScrollViewReader { reader in
                ScrollView{
                    VStack(spacing:15) {
                        ForEach(homeData.msg){ msg in
                            ChatViewRow(chatData: msg)
                                .onAppear{
//                                  First Time Scroll
                                    if msg.id == self.homeData.msg.last!.id && scrolled{
                                        reader.scrollTo(homeData.msg.last!.id,anchor: .bottom)
                                        scrolled = true
                                    }
                                }
                        }
                        .onChange(of: homeData.msg, perform: { value in
//                            You can restrict only for current user scroll....
                            reader.scrollTo(homeData.msg.last!.id,anchor: .bottom)
                        })
                    }
                    .padding(.vertical)
                }
            }
            HStack(spacing:15){
                TextField("Enter Message",text: $homeData.txt)
                    .padding(.horizontal)
//                    Fixed Height For animation
                    .frame(height:45)
                    .background(Color.primary.opacity(0.06))
                    .clipShape(Capsule())
                if homeData.txt != ""{
                    Button(action: {
                        homeData.writeMsg()
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background(Color.green)
                            .clipShape(Circle())
                    })
                }
            }
            .animation(.default)
            .padding()
        }
        .onAppear{
            homeData.onAppear()
        }
        .ignoresSafeArea(.all,edges: .top)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
