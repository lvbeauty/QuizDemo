//
//  ResultViewControllerTest.swift
//  QuizTests
//
//  Created by Tong Yi on 6/5/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import XCTest
@testable import Quiz

class ResultViewControllerTest: XCTestCase
{

    override func setUp() {}

    override func tearDown() {}
    
    func test_viewDidLoad_renderSummary()
    {
        XCTAssertEqual(makeSUT(summary: "A Summary").summaryLabel.text, "A Summary")
    }
    
    func test_viewDidLoad_RendersAnswer()
    {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_configersCell()
    {
        let answer = makeAnswer(question: "Q1", answer: "A1")
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_configersCell()
    {
        let answer = makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "Wrong")
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "Wrong")
    }
    
    //MARK: - Helpers
    
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController
    {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let sut = sb.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        sut.loadViewIfNeeded()
        sut.summary = summary
        sut.answers = answers
        sut.viewDidLoad()
        return sut
    }
    
    func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil) -> PresentableAnswer
    {
        return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
    }
}
