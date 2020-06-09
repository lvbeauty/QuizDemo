//
//  Model.swift
//  Quiz
//
//  Created by Tong Yi on 6/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import Foundation

struct Question: Decodable
{
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

struct QuizModel: Decodable
{
    let results: [Question]
}



