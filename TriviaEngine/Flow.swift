//
//  Flow.swift
//  TriviaEngine
//
//  Created by Adrian on 14.03.21.
//
/* the flow of the application. it's a class because it's more of a behavior than data. */

import Foundation

protocol Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
}

class Flow {
    let router: Router
    let questions: [String]

    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: { [weak self] _ in
                guard let strongSelf = self else { return }
                if let nextQuestionIndex = strongSelf.questions.firstIndex(of: firstQuestion) {
                    let nextQuestion = strongSelf.questions[nextQuestionIndex+1]
                    strongSelf.router.routeTo(question: nextQuestion, answerCallback: { _ in })
                }
            })
        }
    }
}
