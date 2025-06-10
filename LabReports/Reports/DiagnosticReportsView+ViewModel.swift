//
//  DiagnosticReportView+ViewModel.swift
//  LabReports
//
//  Created by Timothy Czyrnyj on 2025-06-02.
//

import Combine
import Foundation
import ModelsR4

extension DiagnosticReportsView {
    final class ViewModel: ObservableObject {
        enum State {
            case idle
            case loading
            case loaded
        }
        
        // For demo purposes
        private let exampleReportURL = URL(string: "https://build.fhir.org/diagnosticreport-example.json")!
        
        private var cancellables: Set<AnyCancellable> = []
        
        // Dependencies
        private let networkService = NetworkService()
        private let dataStore = FHIRMemoryDataStore.shared
        private let decoder = JSONDecoder()
        private lazy var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .short
            return formatter
        }()
        
        // Outputs
        
        @Published var state: State = .idle
        @Published var errorMessage: String?
        var diagnosticReports: [DiagnosticReport] {
            dataStore.reports
        }

        // Inputs
        func loadReports() {
            
            state = .loading
            errorMessage = nil
            if dataStore.reports.count > 0 {
                state = .loaded
                return
            }
            
            networkService.fetchResult(from: exampleReportURL)
                .receive(on: RunLoop.main)
                .sink { [weak self] completion in
                    guard let self else { return }
                    switch completion {
                    case .failure(let error):
                        self.errorMessage = "Error loading resource: \(error.localizedDescription)"
                        self.state = .idle
                    default:
                        self.state = .loaded
                    }
                    
                } receiveValue: { [weak self] (bundle: ModelsR4.Bundle) in
                    guard let self else { return }
                    guard let resources = bundle.entry?.compactMap(\.resource) else {
                        self.state = .idle
                        return
                    }
                    
                    resources.forEach { self.dataStore.save($0) }
                    self.state = .loaded
                }
                .store(in: &cancellables)
        }
    }
}
