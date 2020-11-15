//
//  AppConfigSingleton.swift
//  Daily.v2
//
//  Created by Бакулин Семен Александрович on 08.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//
// Some Configurations over application, like fonts, colors, etc...

import UIKit

final class AppConfig{
    private init(){
        
    }
    
    public static let shared: AppConfig = {
        return AppConfig()
    }()
    
    public let fontLiteral = "Helvetica"
    
    public let navigationBarTitle = "Daily"
    
    public let modelName = "Task"
    
    public let mainBackgroundColor = #colorLiteral(red: 0.1358989477, green: 0.1403667331, blue: 0.1432982385, alpha: 1)
    
    public let secondaryBackgroundColor = #colorLiteral(red: 0.168627451, green: 0.1725490196, blue: 0.1764705882, alpha: 1)
}
