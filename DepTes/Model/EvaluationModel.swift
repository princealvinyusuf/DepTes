//
//  EvaluationModel.swift
//  DepTes
//
//  Created by Prince Alvin Yusuf on 20/03/21.
//

import Foundation
import RealmSwift

class EvaluationModel: Object {
    
    @objc dynamic var diagnosis: String = ""
    @objc dynamic var diagnosisText: String = ""
    @objc dynamic var explanationText: String = ""
    @objc dynamic var suicidalText: String = ""
    @objc dynamic var score: String = ""
    
    @objc dynamic var dateCreated: Date?
    
}
