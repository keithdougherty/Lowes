//
//  UITextField+Combine.swift
//  MovieBrowser
//
//  Created by Keith Dougherty on 6/9/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//


import Foundation

extension DateFormatter {
    public enum Style : UInt {
        case none = 0
        case short = 1
        case medium = 2
        case long = 3
        case full = 4
    }
}

extension DateFormatter {
    static var stringToDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    static var dateToLongStringFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    static var dateToShortStringFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
