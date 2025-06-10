# Medical Lab Results App

An iOS application for displaying medical lab results, built using **Xcode 16.4** and **Apple's FHIRModels** framework for parsing FHIR-compliant data.

## Overview

This app is designed to retrieve, parse, and display lab results using the HL7 FHIR (Fast Healthcare Interoperability Resources) standard. It leverages Apple’s `FHIRModels` Swift framework to handle the structured healthcare data.

## Requirements

- macOS 14 or later  
- Xcode 16.4 or later  
- iOS 17+  
- Swift 5.10+  
- Apple’s [FHIRModels](https://developer.apple.com/documentation/fhirmodels) framework

## Setup Instructions

1. **Clone the repository**

   ```bash
   git clone https://github.com/timcz/LabReports.git
   cd LabReports
   ```

2. **Open the project in Xcode**

   ```bash
   open LabReports.xcodeproj
   ```

3. **Resolve Dependencies**

   This project uses Swift Package Manager to integrate `FHIRModels`. If not automatically resolved:

   - Go to **File > Packages > Resolve Package Versions**

4. **Build & Run**

   Select a target device or simulator, then press `Cmd + R` to build and run the app.

## Assumptions Made During Development

- The app assumes that the incoming FHIR resources are valid and conform to the FHIR R4 specification.
- The current implementation focuses on **read-only access** to lab results (no data submission).
- No authentication layer has been implemented. It is assumed that FHIR resources are provided securely via a trusted mechanism. This sample app downloads an example diagnostic report from  `https://build.fhir.org/diagnosticreport-example.json`
- Only a limited subset of FHIR resource types are currently supported (e.g., `Observation`, `DiagnosticReport`). Additional types can be added as needed.

## Folder Structure

```
LabReports/
├── Home/               # Home view/Welcome view
├── Reports/            # SwiftUI reports views and view models
├── Services/           # Dependencies - Network, DataStores
Screenshots/            # Screenshots of the apps main screens
ClassDiagram.png        # Diagram of the main views, their view models and their dependencies
README.md               # This file
```

## License

This code is provided for evaluation purposes only as part of a job application. 
All rights reserved by the author. Not licensed for reuse or distribution.

---

Readme file generated with ChatGPT.