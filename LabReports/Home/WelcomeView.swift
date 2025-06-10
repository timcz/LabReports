//
//  WelcomeView.swift
//  LabReports
//
//  Created by Timothy Czyrnyj on 2025-06-06.
//

import Foundation

import SwiftUI

struct WelcomeView: View {
    let userName: String = "Jane Doe"
    let lastUpdated: Date = Date() // Replace with real date if available

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Welcome, \(userName)!")
                    .font(.largeTitle.bold())
                    .foregroundColor(.primary)

                Text("Your lab results were last updated on \(formattedDate(lastUpdated)).")
                    .font(.body)
                    .foregroundColor(.secondary)

                Divider()

                VStack(alignment: .leading, spacing: 16) {

                    NavigationLink(destination: AppointmentsView()) {
                        Label("Upcoming Appointments", systemImage: "calendar")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(12)
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct AppointmentsView: View {
    let appointments = (0..<10).map { index in
        let appointmentTypes = ["Physical", "Lab work", "Specialist", "Psychologist"]
        let locations = ["Doctor's Office", "Community Health Center", "University Hospital", "Private Practice"]
        return (
            appointmentTypes.randomElement()!,
            locations.randomElement()!,
            Calendar.current.date(byAdding: .day, value: index * 11, to: Date())!
        )
    }
    private let dateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        Text("Appointment list").font(.headline)
        Text("Coming soon...").font(.caption)
    }
}
