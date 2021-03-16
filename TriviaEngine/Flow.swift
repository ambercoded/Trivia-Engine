//  Created by Adrian on 14.03.21.
/* the flow of the application. it's a class because it's more of a behavior than data. */

import Foundation

// Flow doesnt care what the actual Router is implemented like (DIP)
protocol Router {
    // An associated type gives a placeholder name to a type that’s used as part of the protocol.
    associatedtype Question: Hashable
    associatedtype Answer

    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: [Question: Answer])
}

// only allow routers that have the same question and answer type
class Flow<Question: Hashable, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    private let router: R
    private let questions: [Question]
    private var result: [Question: Answer] = [:]

    init(questions: [Question], router: R) {
        self.questions = questions
        self.router = router
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else { // no questions
            router.routeTo(result: result)
        }
    }

    private func nextCallback(from question: Question) -> (Answer) -> Void {
        return { [weak self] in self?.routeNext(question, $0) }
    }

    private func routeNext(_ question: Question, _ answer: Answer) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer // set the answer for the question before routing

            let nextQuestionIndex = currentQuestionIndex + 1
            let nextQuestionExists = nextQuestionIndex < questions.count
            if nextQuestionExists {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            } else {
                router.routeTo(result: result)
            }
        }

    }
}
