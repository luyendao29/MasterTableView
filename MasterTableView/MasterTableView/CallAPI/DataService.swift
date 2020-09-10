//
//  DataService.swift
//  MasterTableView
//
//  Created by Boss on 9/9/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit

class DataService {
    static let sharing: DataService = DataService()
    
    func getAPI(url: String, completion: @escaping((BaseDataModel) -> Void)) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("fullURLRequest: ", url)
                print("params: ", url.query as Any)
                print("header: ", url.relativeString)
                print("Response json:\n", dataString)
            }
            do {
                let json = try JSONDecoder().decode(BaseDataModel.self, from: data!)
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch let error {
                print(error)
            }
        })
        .resume()
    }
}
