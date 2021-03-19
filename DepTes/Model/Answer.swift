//
//  Answer.swift
//  DepTes
//
//  Created by Prince Alvin Yusuf on 16/03/21.
//

import ResearchKit

public struct Answer {
    
    public let question: Question
    
    public let answerScore: PHQ9ChoiceValue
    
    public init?(stepResult: ORKStepResult) {
        guard let result = stepResult.firstResult as? ORKChoiceQuestionResult,
              let value = result.choiceAnswers?.first as? NSNumber,
              let score = PHQ9ChoiceValue(rawValue: value.intValue),
              let identifier = QuestionIdentifier(rawValue: stepResult.identifier) else { return nil}
        
        answerScore = score
        question = Question(identifier: identifier)
    }
}
