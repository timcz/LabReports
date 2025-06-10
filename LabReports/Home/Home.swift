//
//  Home.swift
//  LabReports
//
//  Created by Timothy Czyrnyj on 2025-06-02.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Tab("Welcome", systemImage: "house") {
                WelcomeView()
            }
            Tab("Reports", systemImage: "document") {
                DiagnosticReportsView()
            }
        }
    }
}

#Preview {
    Home()
}
