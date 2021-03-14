//
//  Flow.swift
//  TriviaEngine
//
//  Created by Adrian on 14.03.21.
//
/* the flow of the application. it's a class because it's more of a behavior than data. */

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
}

class Flow {
    private let router: Router
    private let questions: [String]

    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        }
    }

    private func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let strongSelf = self else { return }
            if let currentQuestionIndex = strongSelf.questions.firstIndex(of: question) {
                let nextQuestionIndex = currentQuestionIndex+1
                if nextQuestionIndex < strongSelf.questions.count {
                    let nextQuestion = strongSelf.questions[nextQuestionIndex]
                    strongSelf.router.routeTo(
                        question: nextQuestion,
                        answerCallback: strongSelf.routeNext(from: nextQuestion))
                }
            }
        }
    }
}
