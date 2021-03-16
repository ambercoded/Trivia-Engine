//  Created by Adrian on 16.03.21.
//

import Foundation

protocol Router {
    // An associated type gives a placeholder name to a type that’s used as part of the protocol.
    associatedtype Question: Hashable
    associatedtype Answer

    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question, Answer>)
}
