//
//  ViewModel.swift
//  Quiz
//
//  Created by Tong Yi on 6/5/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import Foundation

class ViewModel
{
    private var dataSource: [Question] = []
    private let service = Service.shared
    
    init() {}
    
    init(dataSource: [Question]) {
        self.dataSource = dataSource
    }
    
    func getNumberOfQuestions() -> Int
    {
        return dataSource.count
    }
    
    func getCorrectAnswer(for qNumber: Int) -> String
    {
        return dataSource[qNumber].correct_answer
    }
    
    func getWrongAnswer(for qNumber: Int) -> [String]
    {
        return dataSource[qNumber].incorrect_answers
    }
    
    func dataTransfer(url: URL?, completionHandler: @escaping ([Question]?) -> Void)
    {
        service.fetchData(from: url) { (data, response, error) in
            if let error = error
            {
                print(error.localizedDescription)
            }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("response status code: \(httpResponse.statusCode)")
            
            let success = (200...299).contains(httpResponse.statusCode)
            if success
            {
                guard let data = data else { return}
                do
                {
                    let json = try JSONDecoder().decode(QuizModel.self, from: data)
                    self.dataSource = json.results
                }
                catch
                {
                    print(error.localizedDescription)
                }
            }
            completionHandler(self.dataSource)
            
        }
    }
}
