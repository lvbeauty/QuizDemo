//
//  ServiceTest.swift
//  QuizTests
//
//  Created by Tong Yi on 6/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import XCTest
@testable import Quiz

class ServiceTest: XCTestCase
{
    func test_getResponse_withNotExistURL()
    {
        let url = makeFakeURL()
        makeSUT(url: url) { (_, statusCode, _) in
            XCTAssertEqual(statusCode, 404)
        }
    }
    
    func test_getResponse_withCorrectURL()
    {
        let url = makeTrueURL()
        makeSUT(url: url) { (success, _, _) in
            XCTAssertTrue(success)
        }
    }
    
    func test_getResponse_withOutError()
    {
        let url = makeFakeURL()
        makeSUT(url: url)
        { (_, _, error) in
            XCTAssertNil(error)
        }
    }
    
    //MARK: - Helper
    
    private func makeSUT(url: URL?, result: (Bool, Int, Error?) -> Void)
    {
        let asyncExpectation = self.expectation(description: "....asyncExpectation....")
        var statusCode = Int()
        var error: Error?
        
        Service.shared.fetchData(from: url) { (_, response, errorRe) in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            statusCode = httpResponse.statusCode
            error = errorRe
            asyncExpectation.fulfill()
        }
        
        wait(for: [asyncExpectation], timeout: 2)
        
        let success = (200...299).contains(statusCode)
        result(success, statusCode, error)
    }

}
