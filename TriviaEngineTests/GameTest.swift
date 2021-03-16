//
//  GameTest.swift
//  TriviaEngineTests
//
//  Created by Adrian on 16.03.21.
//

import Foundation
import XCTest
import TriviaEngine // necc?

class GameTest: XCTestCase {
    func test_startGame_answerOneOutOfTwoCorrect_scoresOne() {
        let router = RouterSpy()
        startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])

        router.answerCallback("A1")
        router.answerCallback("wrong")

        XCTAssertEqual(router.routedResult!.score, 1)
    }
}
