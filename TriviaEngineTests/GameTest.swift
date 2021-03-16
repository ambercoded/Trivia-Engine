//
//  GameTest.swift
//  TriviaEngineTests
//
//  Created by Adrian on 16.03.21.
//

import Foundation
import XCTest
import TriviaEngine

class GameTest: XCTestCase {
    let router = RouterSpy()
    var game: Game<String, String, RouterSpy>!

    override func setUp() {
        super.setUp()

        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])
    }

    func test_startGame_answerZeroOutOfTwoCorrect_scoresZero() {
        router.answerCallback("wrong")
        router.answerCallback("wrong")

        XCTAssertEqual(router.routedResult!.score, 0)
    }

    func test_startGame_answerOneOutOfTwoCorrect_scoresOne() {
        router.answerCallback("A1")
        router.answerCallback("wrong")

        XCTAssertEqual(router.routedResult!.score, 1)
    }

    func test_startGame_answerTwoOutOfTwoCorrect_scoresTwo() {
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedResult!.score, 2)
    }


}
