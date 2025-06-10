//
//  ObservationView+ViewModel.swift
//  LabReports
//
//  Created by Timothy Czyrnyj on 2025-06-03.
//

import Foundation
import ModelsR4
import SwiftUI

extension ObservationView {
    public struct ViewModel {
        internal init(title: String, value: String, unit: String?, lowValue: String?, highValue: String?, lowUnit: String?, highUnit: String?) {
            self.title = title
            self.value = value
            self.unit = unit
            self.lowValue = lowValue
            self.highValue = highValue
            self.lowUnit = lowUnit
            self.highUnit = highUnit
        }
        
        init(observation: Observation) {
            title = observation.code.text?.value?.string ?? "(code missing)"
            if case .quantity(let quantity) = observation.value {
                let numberFormatter = NumberFormatter()
                numberFormatter.maximumFractionDigits = 2
                numberFormatter.minimumFractionDigits = 2
                value = quantity.value?.value.map(\.decimal).flatMap { numberFormatter.string(from: $0 as NSDecimalNumber) } ?? "(value missing)"
                unit = quantity.unit?.value?.string ?? "(unit missing)"
                
                let referenceRange = observation.referenceRange?.first // Why is this an array?
                lowValue = referenceRange?.low?.value?.value.map(\.decimal).flatMap { numberFormatter.string(from: $0 as NSDecimalNumber) }
                highValue = referenceRange?.high?.value?.value.map(\.decimal).flatMap { numberFormatter.string(from: $0 as NSDecimalNumber) }
                lowUnit = referenceRange?.low?.unit?.value?.string
                highUnit = referenceRange?.high?.unit?.value?.string
                
            } else {
                value = "??"
                unit = nil
                lowValue = nil
                highValue = nil
                lowUnit = nil
                highUnit = nil
            }
        }
        
        let title: String
        let value: String
        let unit: String?
        
        let lowValue: String?
        let highValue: String?
        
        let lowUnit: String?
        let highUnit: String?
        
        var referenceRange: String? {
            if let lowValue, let highValue {
                return "\(lowValue)\(lowUnit ?? "") - \(highValue)\(highUnit ?? "")"
            } else if let lowValue {
                return " > \(lowValue)\(lowUnit ?? "")"
            } else if let highValue {
                return " < \(highValue)\(highUnit ?? "")"
            }
            return nil
        }
    }
}
