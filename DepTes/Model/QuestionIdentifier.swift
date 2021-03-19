//
//  QuestionIdentifier.swift
//  DepTes
//
//  Created by Prince Alvin Yusuf on 15/03/21.
//

import Foundation

// Identifier used to identify questions and the matching results

public enum QuestionIdentifier: String {
    
    case losingInterest // Having little interest or pleasure
    case feelingDepressed // Feeling down, depressed, or hopeless
    case troubleSleeping // Trouble sleeping or sleeping too much
    case feelingTired // Feeling tired or having little energy
    case poorAppetite // Poor appetite or over-eating
    case lowSelfEsteem // Feeling bad about yourself or like a failure
    case troubleConcentrating // Trouble concentrating on things
    case slowOrFast // Moving or speaking slowly or more than usual
    case feelingSuicidal // Thoughts to be better off dead or of hurting yourself
    
    // Total of Question Identifiers
    public static let count: Int = [
        losingInterest,
        feelingDepressed,
        troubleSleeping,
        feelingTired,
        poorAppetite,
        lowSelfEsteem,
        troubleConcentrating,
        slowOrFast,
        feelingSuicidal
    ].count
}
