//
//  Flow.swift
//  Quiz
//
//  Created by Tong Yi on 6/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import Foundation

protocol Router
{
    typealias AnswerCallBack = (String) -> Void
    func routeTo(question: String, answerCallBack: @escaping AnswerCallBack)
    func routeTo(result: [String:String])
}

class Flow
{
    private let router: Router
    private let questions: [String]
    private var result: [String: String] = [:]
    
    init(questions: [String], router: Router)
    {
        self.questions = questions
        self.router = router
    }
    
    func start()
    {
        if let firstQuestion = questions.first
        {
            router.routeTo(question: firstQuestion, answerCallBack: nextCallBack(from: firstQuestion))
        }
        else
        {
            router.routeTo(result: result)
        }
    }
    
    private func nextCallBack(from question: String) -> Router.AnswerCallBack
    {
        return { [weak self] in self?.routeNext(question, $0) }
    }
    
    private func routeNext(_ question: String, _ answer: String)
    {
        if let currentQuestionIndex = self.questions.firstIndex(of: question)
        {
            result[question] = answer
            if currentQuestionIndex < self.questions.count - 1
            {
                let nextQuestion = self.questions[currentQuestionIndex + 1]
                self.router.routeTo(question: nextQuestion, answerCallBack: nextCallBack(from: nextQuestion))
                
            }
            else
            {
                router.routeTo(result: result)
            }
        }
    }
}
