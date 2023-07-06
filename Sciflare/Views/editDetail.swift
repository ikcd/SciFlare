//
//  editDetail.swift
//  Sciflare
//
//  Created by KCD on 06/07/23.
//

import SwiftUI

struct editDetail: View {
    @State var id : String
    @State var name : String
    @State var email : String
    @State var mobile : String
    @State var gender : String
    let db = database.DataBase
    @State var updating : Bool = false
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>

//    init(Model: Binding<model?>?) {
//        if let singlemodel = Model.wrappedValue.first{
//            self._Model = Binding.constant(singlemodel)
//        }else{
//            self._Model = Binding.constant(model.abc[0])
//        }
//    }
    
    var body: some View {
        VStack{
            TextField("", text: $name)
                .textFieldStyle(.roundedBorder)
            
            TextField("", text: $email)
                .textFieldStyle(.roundedBorder)
            
            TextField("", text: $mobile)
                .textFieldStyle(.roundedBorder)
            
            Button {
                updating.toggle()
                
                let _ = db.update(id: id, name: name, email: email, mobile: mobile, gender: gender)
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Update")
            }
            
            
            
        }.overlay {
            if updating{
                ProgressView()
            }
        }
    }
}

//struct editDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        editDetail(Model: .constant(model.abc[0]))
//    }
//}
