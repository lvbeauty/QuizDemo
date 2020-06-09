//
//  QuizTests.swift
//  QuizTests
//
//  Created by Tong Yi on 6/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import XCTest
@testable import Quiz

class FlowTest: XCTestCase
{
    let url = "https://opentdb.com/api.php?amount=10&category=12&difficulty=easy"
    let router = RouterSpy()
    
    func testStartWithNoQuestions_doesNotRouteToQuestion()
    {
        makeSUT(questions: []).start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func testStartWithOneQuestions_routesToCorrectQuestion()
    {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func testStartWithOneQuestions_routesToCorrectQuestion_2()
    {
        makeSUT(questions: ["Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func testStartWithTwoQuestions_routesToCorrectQuestion()
    {
         makeSUT(questions: ["Q1", "Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func testStartTwiceWithTwoQuestions_routesToFirstQuestionTwice()
    {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion()
    {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        router.answerCallBack("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion()
    {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        router.answerCallBack("A1")
        router.answerCallBack("A2")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotRouteToAnotherQuestion()
    {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        router.answerCallBack("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func testStartWithNoQuestions_routeToResult()
    {
        makeSUT(questions: []).start()
        XCTAssertTrue(router.routedResult!.isEmpty)
    }
    
    func test_start_withOneQuestions_doesNotRouteToResult()
    {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotRouteToResult()
    {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        router.answerCallBack("A1")
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routesToResult()
    {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        router.answerCallBack("A1")
        router.answerCallBack("A2")
        XCTAssertEqual(router.routedResult, ["Q1": "A1", "Q2": "A2"])
    }
    
    
    
    

    //MARK: - Helps

    func makeSUT(questions: [String]) -> Flow
    {
        return Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router
    {
        var routedQuestions: [String] = []
        var routedResult: [String: String]?
        var answerCallBack: (String) -> Void = { _ in }
        
        func routeTo(question: String, answerCallBack: @escaping Router.AnswerCallBack)
        {
            routedQuestions.append(question)
            self.answerCallBack = answerCallBack
        }
        
        func routeTo(result: [String : String])
        {
            routedResult = result
        }
        
    }
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
