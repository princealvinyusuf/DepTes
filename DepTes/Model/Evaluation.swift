//
//  Evaluation.swift
//  DepTes
//
//  Created by Prince Alvin Yusuf on 15/03/21.
//

import ResearchKit

public enum Severity: String {
    
    case noDepression
    case minimalDepression
    case milDepression
    case moderateDepression
    case moderatelySevereDepression
    case severeDepression
    
}

public protocol EvaluationType {
    
    var depressiveDisorderConsidered: Bool {
        get
    }
    
    var score: Int {
        get
    }
    
    var severity: Severity {
        get
    }
    
    var suicidal: Bool {
        get
    }
    
    var losingInterestCritical: Bool {
        get
    }
    
    var feelingDepressedCritical: Bool {
        get
    }
    
    var numberOfAnswersCritical: Bool {
        get
    }
    
    var answers: [Answer] {
        get
    }
    
}

public struct Evaluation: EvaluationType {
    public let score: Int
    
    public let severity: Severity
    
    public private(set) var suicidal: Bool
    
    public private(set) var losingInterestCritical: Bool
    
    public private(set) var feelingDepressedCritical: Bool
    
    public let numberOfAnswersCritical: Bool
    
    public var answers: [Answer]
    
    public var depressiveDisorderConsidered: Bool {
        return (losingInterestCritical || feelingDepressedCritical) && numberOfAnswersCritical
    }
    
    public init?(stepResults: [ORKStepResult]) {
        
        guard stepResults.count == QuestionIdentifier.count else {
            return nil
        }
        
        suicidal = false
        losingInterestCritical = false
        feelingDepressedCritical = false
        var numberOfCriticalQuestions = 0
        
        answers = stepResults.compactMap { Answer(stepResult: $0) }
        
        for answer in answers
        where(answer.question.identifier == .feelingSuicidal &&
                answer.answerScore >= .severalDays) || answer.answerScore >= .moreThanHalfTheDays {
            
            numberOfCriticalQuestions += 1
            
            switch answer.question.identifier {
            case .losingInterest:
                losingInterestCritical = true
            case .feelingDepressed:
                feelingDepressedCritical = true
            case .feelingSuicidal:
                suicidal = true
            default:
                break
            }
        }
        
        score = answers.reduce(0) { sum, answer in
            return sum + answer.answerScore.rawValue
        }
        
        self.numberOfAnswersCritical = numberOfCriticalQuestions >= 4
        
        self.severity = Severity(score)
        
    }
}

fileprivate extension Severity {
    
    init(_ score: Int) {
        switch score {
        case 0:
            self = .noDepression
        case 1...4:
            self = .minimalDepression
        case 5...9:
            self = .milDepression
        case 10...14:
            self = .moderateDepression
        case 15...19:
            self = .moderatelySevereDepression
        case 20...27:
            self = .severeDepression
        default:
            self = .noDepression
        }
    }
}




