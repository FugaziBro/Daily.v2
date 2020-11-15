//
//  DateFormatter.swift
//  Daily.v2
//
//  Created by Бакулин Семен Александрович on 10.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

final class DateConverter{
    
    private(set) static var formatLiteral: String = "MMM dd, yyyy"
    
    public static func changeFormatLiteral(newLiteral: String){
        DateConverter.formatLiteral = newLiteral
    }
    
    private static let formatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = DateConverter.formatLiteral
        return formatter
    }()
    
    public static func getDateAsString(date:Date = Date())->String{
        let dateStr = self.formatter.string(from: date)
        return dateStr
    }
}
