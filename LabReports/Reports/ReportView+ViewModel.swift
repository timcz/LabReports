//
//  ReportsView+ViewModel.swift
//  LabReports
//
//  Created by Timothy Czyrnyj on 2025-06-05.
//

import Foundation
import ModelsR4

extension ReportView {
    struct ViewModel {
        init(report: DiagnosticReport) {
            self.report = report
            self.observations = dataStore.observations(forReport: report)
        }
        
        private let report: DiagnosticReport
        let observations: [Observation]
        
        // Dependencies
        let dataStore = FHIRMemoryDataStore.shared
        private let dateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }()
        
        // Outputs
        var reportName: String? {
            report.code.text?.value?.string
        }
        var testReporter: String? {
            report.performer?.first?.display?.value?.string
        }
        var resultDate: String? {
            (try? report.issued?.value?.asNSDate()).map { dateFormatter.string(from: $0 ) }
        }
    }
}
