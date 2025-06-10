//
//  FHIRDataStore.swift
//  LabReports
//
//  Created by Timothy Czyrnyj on 2025-06-05.
//

import Foundation
import ModelsR4

protocol FHIRDataStore {
    var reports: [DiagnosticReport] { get }
    func observations(forReport: DiagnosticReport) -> [Observation]
    
    func save(_ resource: ResourceProxy)
}

class FHIRMemoryDataStore: FHIRDataStore {
    func observations(forReport report: ModelsR4.DiagnosticReport) -> [ModelsR4.Observation] {
        guard let observationIds = report.result?.compactMap(\.reference).compactMap(\.value).compactMap(\.string),
              !observationIds.isEmpty
        else {
            // no results
            return []
        }
        
        return resources.compactMap { $0.get(if: Observation.self) }.filter { observation in
            guard let observationId = observation.id?.value?.string else { return false }
            return observationIds.contains("Observation/\(observationId)")
        }
    }
    
    static var shared: FHIRMemoryDataStore = .init()
    
    private var resources: [ResourceProxy] = []
    
    private init() {}

    var reports: [DiagnosticReport] {
        resources.compactMap { $0.get(if: DiagnosticReport.self) }
    }
    
    func save(_ resource: ResourceProxy) {
        resources.append(resource)
    }
}
