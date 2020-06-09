//
//  ViewModelTestHelpers.swift
//  QuizTests
//
//  Created by Tong Yi on 6/5/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import Foundation

func makeFakeURL() -> URL?
{
    let url = URL(string: "https://github.com/dfgs/djfaklsdjf")
    return url
}

func makeTrueURL() -> URL?
{
    let url = URL(string: "https://opentdb.com/api.php?amount=10&category=12&difficulty=easy")
    return url
}
