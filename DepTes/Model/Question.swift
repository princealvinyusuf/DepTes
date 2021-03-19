//
//  Question.swift
//  DepTes
//
//  Created by Prince Alvin Yusuf on 15/03/21.
//

import ResearchKit

// A struct that contain A Question

public struct Question {
    public let identifier: QuestionIdentifier
    public let title: String
    public let text: String

    /// An `ORKStep`
    public var step: ORKQuestionStep {
        let step = ORKQuestionStep(
            identifier: identifier.rawValue,
            title: title,
            question: text,
            answer: ORKTextChoiceAnswerFormat.phq9Format)
        
        step.isOptional = false
        return step
    }
    
    // Creates a new "Question" from a "QuestionIdentifier"
    // "parameter identifier -> a qustion identifier
    // "returns" -> a newly initialized question
    
    public init(identifier: QuestionIdentifier) {
        
        self.identifier = identifier
        
        switch identifier {
        case .losingInterest:
            title = NSLocalizedString("question_title_losing_interest", comment: "")
            text = NSLocalizedString("question_text_losing_interest", comment: "")
        case .feelingDepressed:
            title = NSLocalizedString("question_title_feeling_depressed", comment: "")
            text = NSLocalizedString("question_text_feeling_depressed", comment: "")
        case .troubleSleeping:
            title = NSLocalizedString("question_title_trouble_sleeping", comment: "")
            text = NSLocalizedString("question_text_trouble_sleeping", comment: "")
        case .feelingTired:
            title = NSLocalizedString("question_title_feeling_tired", comment: "")
            text = NSLocalizedString("question_text_feeling_tired", comment: "")
        case .poorAppetite:
            title = NSLocalizedString("question_title_poor_appetite", comment: "")
            text = NSLocalizedString("question_text_poor_appetite", comment: "")
        case .lowSelfEsteem:
            title = NSLocalizedString("question_title_low_self_esteem", comment: "")
            text = NSLocalizedString("question_text_low_self_esteem", comment: "")
        case .troubleConcentrating:
            title = NSLocalizedString("question_title_trouble_concentrating", comment: "")
            text = NSLocalizedString("question_text_trouble_concentrating", comment: "")
        case .slowOrFast:
            title = NSLocalizedString("question_title_slow_or_fast", comment: "")
            text = NSLocalizedString("question_text_slow_or_fast", comment: "")
        case .feelingSuicidal:
            title = NSLocalizedString("question_title_feeling_suicidal", comment: "")
            text = NSLocalizedString("question_text_feeling_suicidal", comment: "")
        }
    }
}

