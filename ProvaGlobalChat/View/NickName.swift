//
//  NickName.swift
//  ProvaGlobalChat
//
//  Created by Michele on 31/12/20.
//

import SwiftUI

struct NickName: View {
    var name : String
    @AppStorage("current_user") var user = ""
    var body: some View {
        Text(String(name.first!))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background((name == user ? Color.blue : Color.gray).opacity(0.5))
            .clipShape(Circle())
//        contex menù for name display...
            .contentShape(Circle())
            .contextMenu{
                Text(name)
                    .fontWeight(.bold)
            }
    }
}

struct NickName_Previews: PreviewProvider {
    static var previews: some View {
        NickName(name: "Miky")
    }
}
