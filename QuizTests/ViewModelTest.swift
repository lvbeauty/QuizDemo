//
//  ViewModelTest.swift
//  QuizTests
//
//  Created by Tong Yi on 6/5/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import XCTest
@testable import Quiz

class ViewModelTest: XCTestCase
{
    func test_dataModel_rendersQuestions()
    {
        let q1 = Question(question: "Q1", correct_answer: "A1", incorrect_answers: ["W1","W2"])
        let q2 = Question(question: "Q2", correct_answer: "A2", incorrect_answers: ["W2","W2"])
        XCTAssertEqual(ViewModel(dataSource: []).getNumberOfQuestions(), 0)
        XCTAssertEqual(ViewModel(dataSource: [q1]).getNumberOfQuestions(), 1)
        XCTAssertEqual(ViewModel(dataSource: [q1,q2]).getNumberOfQuestions(), 2)
        XCTAssertEqual(ViewModel(dataSource: [q1,q2]).getCorrectAnswer(for: 0), "A1")
        XCTAssertEqual(ViewModel(dataSource: [q1,q2]).getCorrectAnswer(for: 1), "A2")
        XCTAssertEqual(ViewModel(dataSource: [q1,q2]).getWrongAnswer(for: 0), ["W1", "W2"])
    }
    
    func test_dataDecode_rendersQuestions()
    {
        let url = makeTrueURL()
        makeSUT(url: url) { (dataSource) in
            guard let dataSource = dataSource else { return }
            XCTAssertEqual(dataSource.count, 10)
            XCTAssertNotNil(dataSource.first?.question)
        }
        
    }
    
    //MARK: - Helper
    
    private func makeSUT(url: URL?, data: ([Question]?) -> Void)
    {
        let asyncExpectation = self.expectation(description: "....asyncExpectation....")
        var dataSource = [Question]()
        let viewModel = ViewModel()
        
        viewModel.dataTransfer(url: url) { (data) in
            guard let data = data else { return }
            dataSource = data
            asyncExpectation.fulfill()
        }
        
        wait(for: [asyncExpectation], timeout: 2)
        data(dataSource)
    }

}
