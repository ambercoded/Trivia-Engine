//  Created by Adrian on 16.03.21.
// a mocked router for testing

import Foundation
import TriviaEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResult: Result<String, String>? = nil
    var answerCallback: (String) -> Void = { _ in }

    // when a question is shown, we provide an answerCallback to send back the answer later
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }

    func routeTo(result: Result<String, String>) {
        routedResult = result
    }
}
