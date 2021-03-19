//
//  Settings.swift
//  DepTes
//
//  Created by Prince Alvin Yusuf on 15/03/21.
//

import Foundation

public protocol SettingsProtocol: class {
    
    // Number of times user has completed the survey
    var numberOfFinishedSurveys: Int {
        get set
    }
    
    // System asked to request a rating from the user
    var didShowRatingPrompt: Bool {
        get set
    }
    
    // Increments "numberOfFinishedSurveys" by one
    func incrementNumberOfFinishedSurveys()
    
}

// Persistent the data using UserDefaults
class Settings: SettingsProtocol {
    private let finishedSurveysUserDefaultKey = "finishedSurveys"
    private let didShowRatingUserDefaultsKey = "didShowRatingPrompt"
    
    
    var numberOfFinishedSurveys: Int {
        get {
            return UserDefaults.standard.integer(forKey: finishedSurveysUserDefaultKey)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: finishedSurveysUserDefaultKey)
        }
    }
    
    var didShowRatingPrompt: Bool {
        get {
            return UserDefaults.standard.bool(forKey: didShowRatingUserDefaultsKey)
            
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: didShowRatingUserDefaultsKey)
        }
    }
    
    func incrementNumberOfFinishedSurveys() {
        numberOfFinishedSurveys += 1
    }
}
