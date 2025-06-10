//
//  ReportsViwe.swift
//  LabReports
//
//  Created by Timothy Czyrnyj on 2025-06-05.
//

import ModelsR4
import SwiftUI

struct ReportView: View {
    private let viewModel: ViewModel
    init(report: DiagnosticReport) {
        viewModel = .init(report: report)
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("\(viewModel.reportName ?? "none")")
                    .font(.title).bold()
                Text(viewModel.testReporter ?? "none")
                    .font(.body)
                Text(viewModel.resultDate ?? "none")
                    .font(.body)
                ForEach(viewModel.observations, id: \.id) { observation in
                    ObservationView(viewModel: .init(observation: observation))
                }
            }
        }
        .padding()
        .navigationTitle("Diagnostic Report")

    }
}
