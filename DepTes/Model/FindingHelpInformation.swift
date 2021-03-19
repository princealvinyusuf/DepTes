//
//  FindingHelpInformation.swift
//  DepTes
//
//  Created by Prince Alvin Yusuf on 16/03/21.
//

import Foundation

public struct FindingHelpInformation {
    
    public let url: URL
    public let organizationName: String
    
    init(url: URL, organizationName: String) {
        self.url = url
        self.organizationName = organizationName
    }
    
    public init?(locale: Locale) {
        
        guard let language = (locale as NSLocale).object(forKey: NSLocale.Key.languageCode) as? String,
              let country = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String else { return nil }
        
        switch (language, country) {
        case (_, "US"):
            url = URL(string: "http://www.adaa.org/finding-help")!
            organizationName = "Anxiety and Depression Association of America (ADAA) / www.adaa.org"
        case (_, "DE"):
            url = URL(string: "http://www.deutsche-depressionshilfe.de/stiftung/erste-hilfe.php")!
            organizationName = "Stiftung Deutsche Depressionshilfe"
        default:
            return nil
        }
    }
    
}
