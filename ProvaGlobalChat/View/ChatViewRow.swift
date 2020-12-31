//
//  ChatViewRow.swift
//  ProvaGlobalChat
//
//  Created by Michele on 31/12/20.
//

import SwiftUI

struct ChatViewRow: View {
    var chatData : MsgModel
    @AppStorage("current_user") var user = ""
    var body: some View {
        HStack(spacing : 15){
//            nik NameView
            if chatData.user != user{
                NickName(name: chatData.user)
            }
            if chatData.user == user{Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)}
            VStack(alignment: chatData.user == user ? .trailing : .leading, spacing: nil, content: {
                Text(chatData.msg)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
//                   Custom Shape...
                    .clipShape(ChatBubble(myMsg: chatData.user == user))
                Text(chatData.timestamp,style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(chatData.user != user ? .leading:.trailing,10)
                
            })
            if chatData.user == user{
                NickName(name: chatData.user)
            }
            if chatData.user != user{Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)}
        }
        .padding(.horizontal)
//        for scrol Reader
        .id(chatData.id)
    }
}

struct ChatViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatViewRow(chatData: MsgModel(id: "1", msg: "ciao", user: "pippo", timestamp: Date()))
    }
}
