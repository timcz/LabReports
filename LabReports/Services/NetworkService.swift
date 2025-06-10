//
//  ReportService.swift
//  LabReports
//
//  Created by Timothy Czyrnyj on 2025-06-02.
//

import Combine
import Foundation
import ModelsR4

public class NetworkService {
    lazy var decoder = JSONDecoder()

    func fetchResult<T: Decodable>(from url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
