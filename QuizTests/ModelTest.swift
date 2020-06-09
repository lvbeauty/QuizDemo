//
//  ModelTest.swift
//  QuizTests
//
//  Created by Tong Yi on 6/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import XCTest
@testable import Quiz

class ModelTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testQuestionModel_withOneQuestion() throws
    {
        guard let data = Data(base64Encoded: makeDummyJSONData()) else { return }
        let model = try JSONDecoder().decode(QuizModel.self, from: data)
        XCTAssertEqual(getQuestion(from: model).question, "Who is the lead singer of Pearl Jam?")
        XCTAssertEqual(getQuestion(from: model).correct_answer, "Eddie Vedder")
        XCTAssertEqual(getQuestion(from: model).incorrect_answers, ["Ozzy Osbourne", "Stone Gossard", "Kurt Cobain"])
    }
    
    
    
    //MARK: - Helpers
    func makeDummyJSONData() -> String
    {
        let json = """
 {
    results: [
                {
                    category": "Entertainment: Music",
                    "type": "multiple",
                    "difficulty": "easy",
                    "question": "Who is the lead singer of Pearl Jam?",
                    "correct_answer": "Eddie Vedder",
                    "incorrect_answers":["Ozzy Osbourne", "Stone Gossard", "Kurt Cobain"]
                }
            ]
 }
 """
        return json
    }
    
    func getQuestion(from model: QuizModel) -> Question
    {
        return model.results.first ?? Question(question: "", correct_answer: "", incorrect_answers: [])
    }

}
