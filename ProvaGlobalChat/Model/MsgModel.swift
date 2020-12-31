//
//  MsgModel.swift
//  ProvaGlobalChat
//
//  Created by Michele on 31/12/20.
//

import SwiftUI
import FirebaseFirestoreSwift

//For OnChange
struct MsgModel: Codable,Identifiable,Hashable {
    @DocumentID var id: String?
    var msg : String = ""
    var user : String = ""
    var timestamp : Date
}
enum CodingKeys : String,CodingKey {
        case id
        case msg
        case user
        case timestamp
        
}

