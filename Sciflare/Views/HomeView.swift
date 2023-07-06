//
//  HomeView.swift
//  Sciflare
//
//  Created by KCD on 05/07/23.
//

import SwiftUI

struct HomeView: View {
    let apiCall = ApiCalls()
    let Decode = decoder()
    let db = database.DataBase
    @EnvironmentObject private var appDelegate : AppDelegate

    @AppStorage("count") var count : Int?
    var body: some View {
        TabView {
            studentList()
                .tabItem {
                    Image(systemName: "house")
                }
            mapView()
                .tabItem {
                    Image(systemName: "map")
                }
        }
        .onAppear(){
            print("initiak_________________________________")
            apiCall.getApi(endpoint: ""){data in
                Decode.decodeJson(data: data!) { responseBody in
                    let a  = responseBody?.count ?? 0
                    print("tttttttt\(a)")
                    if responseBody?.count ?? 0  > count ?? 0 {
                        db.insert(data: responseBody ?? model.abc)
                    }else{
                        print("lesser")
                    }
                }
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
