//
//  ObservationView.swift
//  LabReports
//
//  Created by Timothy Czyrnyj on 2025-06-03.
//

import SwiftUI

struct ObservationView: View {
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    let viewModel: ViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Color.gray.opacity(0.1).frame(height: 1).padding(8)
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                    Text(viewModel.value).font(.title2) + Text(viewModel.unit ?? "").font(.body)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Normal Range")
                        .font(.body).foregroundStyle(.gray)
                    Text(viewModel.referenceRange ?? "")
                        .font(.body)
                }
            }
        }
    }
}

#Preview {
    ObservationView(viewModel: .init(title: "Red cell count", value: "5.9", unit: "x 10^12/L", lowValue: "4.2", highValue: "6.0", lowUnit: "x 10^12/L", highUnit: "x 10^12/L"))
}
