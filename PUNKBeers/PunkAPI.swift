//
//  PunkAPI.swift
//  39951
//
//  Created by Rafael dos Santos Calderani on 25/11/17.
//  Copyright © 2017 Rafael dos Santos Calderani. All rights reserved.
//

import Foundation

class PunkAPI {
    
    private static let API_URL = "https://api.punkapi.com/v2/beers"
    
    static func getBeers(onComplete: @escaping (_ success: [Beer]?)->()){
        guard let url = URL(string: API_URL) else {
            onComplete(nil)
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("Erro ao criar a Data Task. Detalhes: ", error!.localizedDescription)
                onComplete(nil)
            }
            else {
                guard let response = response as? HTTPURLResponse else {
                    onComplete(nil)
                    return
                }
                
                if response.statusCode == 200 {
                    guard let data = data else {
                        onComplete(nil)
                        return
                    }
                    
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [[String: Any]]
                        
                        var beers: [Beer] = []
                        
                        for item in json {
                            let imageURL = item["image_url"] as? String
                            let name = item["name"] as? String
                            let tagline = item["tagline"] as? String ?? ""
                            let abv = item["abv"] as? Double ?? 0.0
                            let ibu = item["ibu"] as? Double ?? 0.0
                            let description = item["description"] as? String ?? ""
                            
                            // makes sure that the imgURL and name aren't null
                            if (imageURL != nil && name != nil) {
                                let beer = Beer(imageURL: imageURL!, name: name!, tagline: tagline, abv: abv, ibu: ibu, description: description)
                            
                                beers.append(beer)
                            }
                        }
                        onComplete(beers)
                    }
                    catch {
                        print(error.localizedDescription)
                        onComplete(nil)
                    }
                }
                else {
                    print("Erro ao fazer a requisição. Código de Saída: ", response.statusCode)
                    onComplete(nil)
                }
            }
            
        }        
        task.resume()
    }
}
