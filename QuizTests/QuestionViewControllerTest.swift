//
//  QuizTest.swift
//  QuizTests
//
//  Created by Tong Yi on 6/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import XCTest
@testable import Quiz

class QuestionViewControllerTest: XCTestCase
{
    func test_viewDidLoad_renderQuestionLabelText()
    {
        XCTAssertEqual(makeSUT(question: "Q1").questionLabel.text, "Q1")
    }
    
    func test_viewDidLoad_renderOptions()
    {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_renderOptionsText()
    {
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
    }
    
    func test_optionSelected_withSingleOption_notifiesDelegateWithLastSelection()
    {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionDeselected_withSingleOption_doesNotNotifyDelegateWithEmptySelection()
    {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1", "A2"]) { _ in callbackCount += 1 }
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionSelected_withMultipleOptionsEnabled_notifiesDelegateWithLastSelection()
    {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
    }
    
    func test_optionDeselected_withMultipleOptionsEnabled_notifiesDelegateWithLastSelection()
    {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    
    
    //MARK: - Helpers
    func makeSUT(question: String = "", options: [String] = [], selection: @escaping ([String]) -> Void = {_ in}) -> QuestionViewController
    {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let sut = sb.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        sut.loadViewIfNeeded()
        sut.question = question
        sut.options = options
        sut.selection = selection
        sut.viewDidLoad()
        return sut
    }
}
