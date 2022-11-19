//
//  ApiHandler.swift
//  MobilliumCase
//
//  Created by İlayda Öner on 18.11.2022.
//
import Foundation
import Alamofire

class APIHandler {
    static let sharedInstance = APIHandler()
    
    func fetchingAPIData(url: URL, handler: @escaping (_ apiData:[Flight])->(Void)){
        
        AF.request (url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode([Flight].self, from: data!)
                   //Closure Calling
                    handler(jsondata)
                }catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                
              
            }
        }
    }
}

