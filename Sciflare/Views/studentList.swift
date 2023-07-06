//
//  studentList.swift
//  Sciflare
//
//  Created by KCD on 05/07/23.
//


import SwiftUI

struct studentList: View {
    let apiCall = ApiCalls()
    let Decode = decoder()
    let db = database.DataBase
    @State var StudentsList : [model]?
    @State var detail : model?
    var body: some View {
        NavigationStack {
            VStack(spacing: 10){
                ScrollView {
                    let _ = print(StudentsList?.count)
                    ForEach(StudentsList?.indices ?? 0..<0, id: \.self) { i in
                        NavigationLink {
                            EmptyView()
                            editDetail(id: StudentsList?[i].id ?? "", name: StudentsList?[i].name ?? "", email: StudentsList?[i].email ?? "", mobile: StudentsList?[i].mobile ?? "", gender: StudentsList?[i].gender ?? "")
                        } label: {
                            VStack(alignment: .leading){
                                HStack {
                                    Text(StudentsList?[i].name ?? "")
                                    Spacer()
                                    Text(StudentsList?[i].mobile ?? "")
                                }
                                HStack {
                                    Text(StudentsList?[i].email ?? "")
                                }
                            }
                            .padding(.all, 10)
                            .foregroundColor(.black)
                            .background(.gray)
                            .cornerRadius(10)
                        }

                    }
                    .padding(.horizontal, 10)
                }
            }.onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    StudentsList = db.fetchTable()
                }
            }
        }
    }
}

struct studentList_Previews: PreviewProvider {
    static var previews: some View {
        studentList()
    }
}
