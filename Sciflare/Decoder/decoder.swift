
import Foundation

class decoder{
    func decodeJson(data : Data, completetionHandler : @escaping (_ data: [Sciflare.model]?) -> ()){
        do {
            let decoder = JSONDecoder()
            let responseObject = try decoder.decode([model].self, from: data)
            print(responseObject)
            completetionHandler(responseObject)
        }catch{
            print("Json parse error\(error)\n\(error._code)\n\(error._domain)\n\(error.localizedDescription)")
        }
    }
}
