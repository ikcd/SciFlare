//
//  database.swift
//  Sciflare
//
//  Created by KCD on 06/07/23.
//

import Foundation
import SQLite3
import SwiftUI

class database{
    static let DataBase = database()
    @AppStorage("count") var count : Int?
    var db : OpaquePointer?
    
    init(){
           let fileurl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("studentsList.sqlite")
       
           if sqlite3_open(fileurl.path, &db) != SQLITE_OK{
               print("error creating DB")
               return
           }else{
               print(fileurl.path)
           }
       
        let studentList = "CREATE TABLE IF NOT EXISTS studentsListTable (id TEXT, student_name TEXT, student_email TEXT, student_mobile TEXT, student_gender TEXT)"
       
           if sqlite3_exec(db, studentList, nil, nil, nil) != SQLITE_OK{
               print("can't create table")
               return
           }
       }
    
    func insert(data : [model]){
        var statemnt : OpaquePointer?
        if data != nil {
            for i in data{
                let id = i.id
                let name = i.name
                let email = i.email
                let mobile = i.mobile
                let gender = i.gender
                let insertIntoTable = "INSERT INTO studentsListTable (id,student_name,student_email,student_mobile,student_gender) VALUES (?,?,?,?,?)"
                if sqlite3_prepare_v2(db, insertIntoTable, -1, &statemnt, nil) != SQLITE_OK{
                    print("error binding qry")
                }
                if sqlite3_bind_text(statemnt, 1, (id as NSString).utf8String, -1, nil) != SQLITE_OK {
                    print("error binding id to query")
                }
                if sqlite3_bind_text(statemnt, 2, (name as NSString).utf8String, -1, nil) != SQLITE_OK {
                    print("error binding name to query")
                }
                if sqlite3_bind_text(statemnt, 3, (email as NSString).utf8String, -1, nil) != SQLITE_OK {
                    print("error binding email to query")
                }
                if sqlite3_bind_text(statemnt, 4, (mobile as NSString).utf8String, -1, nil) != SQLITE_OK {
                    print("error binding mobile to query")
                }
                if sqlite3_bind_text(statemnt, 5, (gender as NSString).utf8String, -1, nil) != SQLITE_OK {
                    print("error binding gender to query")
                }
                if sqlite3_step(statemnt) == SQLITE_DONE {
                    print("song Insertion Success")
                } else{
                    print("insertion iyoooooooiyoooooo \(statemnt)")
                }
            }
        }
    }
    
//    func rowCount() -> Int{
//        var i = 0
//        var statemnt : OpaquePointer? = nil
//        let fetchQuery = "select * from studentsListTable"
//        if sqlite3_prepare_v2(self.db, fetchQuery, -1, &statemnt, nil) == SQLITE_OK {
//            while sqlite3_step(statemnt) == SQLITE_ROW {
//                count = sqlite3_column_int(statemnt, 0)
//            }
//        }
//        return co
//    }
    
    func update(id : String, name : String, email : String, mobile : String, gender : String) -> Bool{
        var statemnt : OpaquePointer? = nil
        let updateQuery = """
UPDATE studentsListTable SET student_name = "\(name)", student_email = "\(email)", student_mobile = "\(mobile)" WHERE id = "\(id)"
"""
        if sqlite3_prepare_v2(db, updateQuery, -1, &statemnt, nil) == SQLITE_OK {
            if sqlite3_step(statemnt) == SQLITE_DONE {
                return true
            }
        }
        return false
    }
    
    func fetchTable() -> [model]{
        var statemnt : OpaquePointer? = nil
        var namesArray = [model]()
        var value : String? = nil
        let fetchQuery = "select * from studentsListTable"
        if sqlite3_prepare_v2(self.db, fetchQuery, -1, &statemnt, nil) == SQLITE_OK {
            while sqlite3_step(statemnt) == SQLITE_ROW {
                let id = String(cString: sqlite3_column_text(statemnt, 0))
                let name = String(cString: sqlite3_column_text(statemnt, 1))
                let email = String(cString: sqlite3_column_text(statemnt, 2))
                let mobile = String(cString: sqlite3_column_text(statemnt, 3))
                let gender = String(cString: sqlite3_column_text(statemnt, 4))
                namesArray.append(model(id: id, name: name, email: email, mobile: mobile, gender: gender))
                count = (count ?? 0) + 1
            }
        }
        return namesArray.count > 0 ? namesArray : []
    }
}
