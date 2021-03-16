//  Created by Adrian on 14.03.21.
/* the flow of the application. it's a class because it's more of a behavior than data. */

import Foundation

// only allow routers that have the same question and answer type
// enforce the Router's Question and Answer generic types match
// the Flow's Question and Answer generic types
class Flow<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    private let router: R
    private let questions: [Question]
    private var answers: [Question: Answer] = [:]
    private var scoring: ([Question: Answer]) -> Int // scoring closure is passed in (not the flows task)

    init(questions: [Question], router: R, scoring: @escaping ([Question: Answer]) -> Int) {
        self.questions = questions
        self.router = router
        self.scoring = scoring
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else { // no questions
            router.routeTo(result: result())
        }
    }

    private func nextCallback(from question: Question) -> (Answer) -> Void {
        return { [weak self] in self?.routeNext(question, $0) }
    }

    private func routeNext(_ question: Question, _ answer: Answer) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            answers[question] = answer // set the answer for the question before routing

            let nextQuestionIndex = currentQuestionIndex + 1
            let nextQuestionExists = nextQuestionIndex < questions.count
            if nextQuestionExists {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            } else {
                router.routeTo(result: result())
            }
        }
    }

    private func result() -> Result<Question, Answer> {
        return Result(answers: answers, score: scoring(answers))
    }
}
