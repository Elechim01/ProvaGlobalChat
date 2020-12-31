//
//  ChatBubble.swift
//  ProvaGlobalChat
//
//  Created by Michele on 31/12/20.
//

import SwiftUI

struct ChatBubble: Shape {
    var myMsg : Bool
    func path(in rect:CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,byRoundingCorners: [.topLeft,.topRight,myMsg ? .bottomLeft : .bottomRight],cornerRadii: CGSize(width: 15, height: 15))
        return Path(path.cgPath)
    }
}

