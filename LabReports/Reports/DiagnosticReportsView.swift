//
//  ContentView.swift
//  LabReports
//
//  Created by Timothy Czyrnyj on 2025-05-30.
//

import SwiftUI
import ModelsR4

struct DiagnosticReportsView: View {
    
    @StateObject var viewModel: ViewModel = .init()
    private let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            VStack {
                errorView
                
                Spacer()
                
                switch viewModel.state {
                case .loaded:
                    reportsView
                case .idle:
                    loadView
                case .loading:
                    loadingView
                }
                
                Spacer()
                
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .navigationTitle("Diagnostic Reports")
        }
        .onAppear() {
            viewModel.loadReports()
        }
    }
    
    @ViewBuilder
    var errorView: some View {
        if let errorMessage = viewModel.errorMessage {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.red)
                Text(errorMessage)
                
            }.padding()
                .background(Color.yellow.opacity(0.5))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
        }
    }
    
    @ViewBuilder
    var loadView: some View {
        Button("Load") {
            viewModel.loadReports()
        }
        .foregroundStyle(.white)
        .padding([.leading, .trailing], 64)
        .padding([.top, .bottom], 12)
        .background(Color.blue)
        .clipShape(.capsule)
    }
    
    @ViewBuilder
    var loadingView: some View {
        ProgressView().progressViewStyle(CircularProgressViewStyle())
        Text("Loading reports...")
            .font(.title)
    }
    
    @ViewBuilder
    var reportsView: some View {
        let reports = viewModel.diagnosticReports
        if reports.isEmpty {
            Text("No reports available.")
            .foregroundColor(.gray)
        } else {
            let displayReports = reports.compactMap { report in
                if let id = report.id?.value?.string {
                    return (id: id, report: report)
                }
                return nil
            }
            
            List(displayReports, id: \.id) { displayReport in
                NavigationLink(destination:
                                ReportView(
                                    report: displayReport.report,
                                )
                ) {
                    VStack(alignment: .leading) {
                        Text(displayReport.report.code.text?.value?.string ?? "(missing title)")
                            .font(.title).bold()
                        Text(displayReport.report.performer?.first?.display?.value?.string ?? "(missing test performer)")
                            .font(.body)
                        Text((try? displayReport.report.issued?.value?.asNSDate()).map { dateFormatter.string(from: $0 ) } ?? "(date not found)")
                            .font(.body)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    DiagnosticReportsView()
}
