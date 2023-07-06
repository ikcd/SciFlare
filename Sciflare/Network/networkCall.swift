
import Foundation
import SwiftUI


class ApiCalls{
    func getApi(endpoint : String, completionHandler : @escaping (_ data : Data?) -> ()){
        let url = URL(string: Endpoint.baseUrl + endpoint)
        let call = URLSession.shared.dataTask(with: url!){ data, response, error in
            guard let data = data,
                error == nil,
                let res = response as? HTTPURLResponse,
                (res.statusCode >= 200 && res.statusCode < 300) else {
                    print("statusCode should be 2xx, but is")
                    return completionHandler(data)
                }
            completionHandler(data)
        }
        call.resume()
    }
}
