//
//  Service.swift
//  Quiz
//
//  Created by Tong Yi on 6/5/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class Service
{
    static let shared = Service()
    private init() {}
    typealias CompleteHandler = (Data?, URLResponse?, Error?) -> Void
    
    
    func fetchData(from url: URL?, completeHandler: @escaping CompleteHandler)
    {
        guard let url = url else { return }

        let task = URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print(httpResponse.statusCode)
            completeHandler(data, response, error)
        }
        task.resume()
    }
}
