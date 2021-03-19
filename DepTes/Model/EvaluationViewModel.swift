//
//  EvaluationViewModel.swift
//  DepTes
//
//  Created by Prince Alvin Yusuf on 16/03/21.
//

import Foundation

public struct EvaluationViewModel {
    
    public let diagnosis: String
    public let diagnosisText: String
    public let explanationText: String
    public let suicidalText: String?
    public let score: String
    public let shouldDisplayScore: Bool
    public let answers: [(String, String)]
    public let findingHelpViewModel: FindingHelpViewModel?
    public var shouldDisplayFindingHelpInformation: Bool {
        return findingHelpViewModel != nil
    }
    
    public var shouldPromptForReview: Bool {
        if ProcessInfo.processInfo.environment["UITests"]?.isEmpty == false {
            return false
        }
        
        return settings.didShowRatingPrompt == false && settings.numberOfFinishedSurveys > 1
    }
    
    private let settings: SettingsProtocol
    
    public init(evaluation: EvaluationType, findingHelpInformation: FindingHelpInformation?, settings: SettingsProtocol) {
        
        self.settings = settings
        
        if let findingHelpInformation = findingHelpInformation {
            findingHelpViewModel = FindingHelpViewModel(info: findingHelpInformation)
        } else {
            findingHelpViewModel = nil
        }
        
        if evaluation.depressiveDisorderConsidered {
            
            explanationText = NSLocalizedString("explanation_depression", comment: "")
            
            switch evaluation.severity {
            case .noDepression:
                diagnosis = NSLocalizedString("diagnosis_no_depression", comment: "")
                diagnosisText = NSLocalizedString("diagnosis_text_no_depression", comment: "")
            case .minimalDepression:
                diagnosis = NSLocalizedString("diagnosis_minimal_depression", comment: "")
                diagnosisText = NSLocalizedString("diagnosis_text_minimal_depression", comment: "")
            case .milDepression:
                diagnosis = NSLocalizedString("diagnosis_mild_depression", comment: "")
                diagnosisText = NSLocalizedString("diagnosis_text_mild_depression", comment: "")
            case .moderateDepression:
                diagnosis = NSLocalizedString("diagnosis_moderate_depression", comment: "")
                diagnosisText = NSLocalizedString("diagnosis_text_moderate_depression", comment: "")
            case .moderatelySevereDepression:
                diagnosis = NSLocalizedString("diagnosis_moderately_severe_depression", comment: "")
                diagnosisText = NSLocalizedString("diagnosis_text_moderately_severe_depression", comment: "")
            case .severeDepression:
                diagnosis = NSLocalizedString("diagnosis_severe_depression", comment: "")
                diagnosisText = NSLocalizedString("diagnosis_text_severe_depression", comment: "")
           
            }
        } else {
            diagnosis = NSLocalizedString("diagnosis_no_depression", comment: "")
            diagnosisText = NSLocalizedString("diagnosis_text_no_depression", comment: "")
            
            if evaluation.numberOfAnswersCritical {
                explanationText = NSLocalizedString("explanation_no_depression_first_questions_not_critical", comment: "")
            } else {
                explanationText = NSLocalizedString("explanation_no_depression_not_enough_answers_critical", comment: "")
            }
        }
        
        if evaluation.suicidal {
            suicidalText = NSLocalizedString("suicidal_text", comment: "")
        } else {
            suicidalText = nil
        }
        
        shouldDisplayScore = evaluation.depressiveDisorderConsidered
        
        score = String(evaluation.score)
        
        answers = evaluation.answers.map {
            ($0.question.title, String($0.answerScore.rawValue))
        }
    }
    
    public func didShowReviewPrompt() {
        settings.didShowRatingPrompt = true
    }
}

public struct FindingHelpViewModel {
    
    public let url: URL
    public let credits: String
    
    public init(info: FindingHelpInformation) {
        url = info.url as URL
        credits = String(format: NSLocalizedString("find_help_credits_format", comment: ""), info.organizationName)
    }
    
}
