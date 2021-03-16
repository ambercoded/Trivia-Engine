//  Created by Adrian on 16.03.21.
//

import Foundation

public protocol Router {
    // associated types give placeholder names to types in protocols
    associatedtype Question: Hashable
    associatedtype Answer

    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question, Answer>)
}
