//
//  ORKTextChoiceExtensions.swift
//  DepTes
//
//  Created by Prince Alvin Yusuf on 15/03/21.
//

import ResearchKit

public enum PHQ9ChoiceValue: Int {
    
    // Basic Answer Choice
    case notAtAll = 0
    case severalDays = 1
    case moreThanHalfTheDays = 2
    case nearlyEveryDay = 3
    
    fileprivate var nsNumberValue: NSNumber {
        return NSNumber(value: rawValue)
    }
    
}

extension PHQ9ChoiceValue: Comparable {
    
    public static func < (lhs: PHQ9ChoiceValue, rhs: PHQ9ChoiceValue) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension ORKTextChoice {
    
    // Choices from the user, expressing the frequency
    static let phq9Choices: [ORKTextChoice] = [
        ORKTextChoice(
            text: NSLocalizedString("choice_not_at_all", comment: ""),
            value: PHQ9ChoiceValue.notAtAll.nsNumberValue),
        ORKTextChoice(
            text: NSLocalizedString("choice_several_days", comment: ""),
            value: PHQ9ChoiceValue.severalDays.nsNumberValue),
        ORKTextChoice(
            text: NSLocalizedString("choice_more_than_half_the_days", comment: ""),
            value: PHQ9ChoiceValue.moreThanHalfTheDays.nsNumberValue),
        ORKTextChoice(
            text: NSLocalizedString("choice_nearly_every_day", comment: ""),
            value: PHQ9ChoiceValue.nearlyEveryDay.nsNumberValue),
    ]
}

extension ORKTextChoiceAnswerFormat {
    
    static let phq9Format: ORKTextChoiceAnswerFormat =
        ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: ORKTextChoice.phq9Choices)
}
