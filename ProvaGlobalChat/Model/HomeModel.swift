//
//  HomeModel.swift
//  ProvaGlobalChat
//
//  Created by Michele on 31/12/20.
//

import Foundation
import SwiftUI
import Firebase
class HomeModel: ObservableObject {
    @Published var txt = "" 	
    @Published var msg : [MsgModel] = []
    @AppStorage("current_user") var user = ""
    let ref = Firestore.firestore()
    init() {
        readAllMsg()
    }
    
    func onAppear(){
//        Checking whether users is joined already..
        if user == ""{
//            join alert
            UIApplication.shared.windows.first?.rootViewController?.present(alertView(), animated: true)
        }
    }
    func alertView()-> UIAlertController{
        let alert = UIAlertController(title: "Join Chat !!!", message: "Enter Nick Name", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (txt) in
            txt.placeholder = "eg Miky"
        })
        let join = UIAlertAction(title: "Join", style: .default, handler: {(_)in
//            ceckhing for empty click
            let user = alert.textFields![0].text ?? ""
            
            if user != ""{
                self.user = user
                return
            }
//            repromiting alrt view
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)

        })
        alert.addAction(join)
        return alert
    }
//    Lettura dei dati da un databse
    func readAllMsg(){
        ref.collection("Msgs").order(by: "timestamp",descending: false).addSnapshotListener({(snap,err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            guard let data = snap else{return}
            data.documentChanges.forEach{(doc) in
//                Adding when data is added
                if doc.type == .added{
                    let msg = try! doc.document.data(as: MsgModel.self)!
                    DispatchQueue.main.async {
                        self.msg.append(msg)
                    }
                }
            }
        })
    }
    func writeMsg(){
        let msg = MsgModel(msg: txt, user: user, timestamp: Date())
        let _ = try! ref.collection("Msgs").addDocument(from: msg, completion: {(err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            self.txt = ""
        })
    }
    
}
