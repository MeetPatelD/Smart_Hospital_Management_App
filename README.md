# Smart Hospital Management System

A role-based Flutter mobile application for managing hospital workflows through a single platform for **Admin**, **Doctor**, and **Patient/User** roles.

The app is built with **Flutter** and **Dart**, uses **Provider** for state management, and includes **Shared Preferences** support for lightweight local persistence. It follows a modular architecture with separated layers for authentication, dashboards, features, models, services, and reusable widgets. [file:8][web:1][web:2]

---

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Project Flow](#project-flow)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Folder Structure](#folder-structure)
- [Screens & Modules](#screens--modules)
- [Installation](#installation)
- [How to Run](#how-to-run)
- [Demo Credentials](#demo-credentials)
- [Future Enhancements](#future-enhancements)
- [License](#license)

---

## Overview

Smart Hospital Management System is designed to simplify basic hospital operations in a structured mobile experience. The project supports role-based access, appointment booking, doctor management, patient management, and appointment tracking from one app interface. [file:8]

The application starts from the login screen and routes users into different experiences based on their selected role. Admin users can manage doctors and patients, doctors can view and complete assigned appointments, and patients can browse doctors, book appointments, and track their appointment history. [file:8]

---

## Key Features

- Role-based login for **Admin**, **Doctor**, and **User/Patient**.
- Separate dashboards based on user role.
- Doctor management with add/delete actions.
- Patient management with add/delete actions.
- Appointment booking with date, time, and issue description.
- Doctor appointment workflow with complete/cancel actions and prescription entry.
- Appointment history and user-specific appointment filtering.
- Reusable UI components for buttons, input fields, cards, and stat cards.
- Centralized routes, theme setup, and provider-based state handling. [file:8]

---

## Project Flow

The app follows a simple end-to-end hospital workflow:

1. **User opens the app** and lands on the login screen. [file:8]
2. **User logs in** by selecting a role and entering email/password credentials. [file:8]
3. **AuthProvider validates** the credentials against the in-memory user dataset. [file:8]
4. On success, the app navigates to the **HomeScreen**. [file:8]
5. The **bottom navigation and dashboard content** change depending on the current role. [file:8]
6. **Admin flow:** manage doctors, manage patients, and view full appointment history/analytics. [file:8]
7. **Doctor flow:** view assigned appointments, mark them complete or cancel them, and add prescriptions. [file:8]
8. **Patient flow:** view doctors, book appointments, and track personal appointment history. [file:8]

This role-based navigation makes the app easier to understand, maintain, and extend. [file:8]

---

## Architecture

The project is organized into clear layers:

- **Core**: app theme, routes, providers, and reusable widgets. [file:8]
- **Features**: screen-based modules for auth, dashboard, doctor, patient, appointment, and admin functionality. [file:8]
- **Models**: data classes for `User`, `Doctor`, `Patient`, and `Appointment`. [file:8]
- **Services**: data source and appointment persistence logic. [file:8]

State management is handled with **Provider**, where `AppProvider` manages app-wide state like theme/loading/role, and `AuthProvider` manages authentication state and current user details. This matches Provider’s intended use as a clean wrapper around stateful logic with reduced boilerplate and scalable state consumption. [file:8][web:2]

---

## Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform mobile application framework. [web:1] |
| Dart | Application logic and UI language. [file:8] |
| Provider | State management and app-wide state access. [file:8][web:2] |
| Shared Preferences | Lightweight local key-value persistence. [file:8][web:3] |
| Material 3 | UI styling and components. [file:8] |

---

## Folder Structure

```text
lib/
├── core/
│   ├── providers/
│   │   └── appprovider.dart
│   ├── routes/
│   │   └── approutes.dart
│   ├── theme/
│   │   └── apptheme.dart
│   └── widgets/
│       ├── custombutton.dart
│       ├── customtextfield.dart
│       ├── dashboardcard.dart
│       └── statscard.dart
├── features/
│   ├── auth/
│   │   ├── providers/
│   │   │   └── authprovider.dart
│   │   └── screens/
│   │       ├── loginscreen.dart
│   │       └── signupscreen.dart
│   ├── dashboard/
│   │   └── screens/
│   │       ├── dashboardscreen.dart
│   │       └── homescreen.dart
│   ├── doctor/
│   │   └── screens/
│   │       ├── doctorscreen.dart
│   │       ├── alldoctorsscreen.dart
│   │       ├── doctorappointmentsscreen.dart
│   │       ├── doctorschedulescreen.dart
│   │       └── doctorprofilescreen.dart
│   ├── patient/
│   │   └── screens/
│   │       └── patientscreen.dart
│   ├── appointment/
│   │   └── screens/
│   │       ├── appointmentscreen.dart
│   │       └── userappointmentsscreen.dart
│   └── admin/
│       └── screens/
│           ├── adminanalyticsscreen.dart
│           └── allappointmenthistoryscreen.dart
├── models/
│   ├── appointment.dart
│   ├── doctor.dart
│   ├── patient.dart
│   └── user.dart
├── services/
│   ├── dataservice.dart
│   └── appointmentservice.dart
└── main.dart
```

---

## Screens & Modules

### Authentication
- `LoginScreen`: handles login with role selection.
- `SignupScreen`: creates new patient/user accounts.
- `AuthProvider`: manages login, signup, logout, and current user state. [file:8]

### Dashboard
- `DashboardScreen`: shows role-based summary cards and quick actions.
- `HomeScreen`: manages bottom navigation and role-based tab layout. [file:8]

### Doctor Management
- `DoctorScreen`: admin screen to add/delete doctors.
- `AllDoctorsScreen`: user-facing doctor list for booking appointments.
- `DoctorAppointmentsScreen`: doctor view of assigned appointments.
- `DoctorScheduleScreen`: doctor schedule overview.
- `DoctorProfileScreen`: doctor profile summary. [file:8]

### Patient Management
- `PatientScreen`: admin screen to add/delete patient records. [file:8]

### Appointments
- `AppointmentScreen`: books appointments with date, time, doctor, and problem description.
- `UserAppointmentsScreen`: displays only the logged-in user’s appointments. [file:8]

### Admin Tools
- `AdminAnalyticsScreen`: overview of doctors, patients, appointment status counts, and quick insights.
- `AllAppointmentHistoryScreen`: complete appointment history and status tracking. [file:8]

---

## Demo Credentials

The app includes sample in-memory users for demo/testing purposes:

| Role | Example Login |
|---|---|
| Admin | `admin@gmail.com` / `1234` |
| Doctor | `raj@gmail.com` / `1234` |
| Doctor | `priya_doctor@gmail.com` / `1234` |
| Doctor | `rahul_doctor@gmail.com` / `1234` |
| User | `user@gmail.com` / `1234` |

These values are part of the sample dataset used in `DataService`. [file:8]

---

## Installation

### Prerequisites
- Flutter SDK installed.
- Dart SDK compatible with the project environment.
- Android Studio, VS Code, or any Flutter-supported IDE. [web:1]

### Clone the repository
```bash
git clone https://github.com/your-username/smart-hospital-management.git
cd smart-hospital-management
```

### Install dependencies
```bash
flutter pub get
```

### Run the app
```bash
flutter run
```

If you are running on a specific device or emulator:
```bash
flutter devices
flutter run -d <device_id>
```

---

## How to Run

1. Open the project in your Flutter IDE.
2. Run `flutter pub get`.
3. Start an emulator or connect a device.
4. Launch the app using `flutter run`.
5. Use the demo credentials to explore Admin, Doctor, and User flows. [file:8]

---

## Project Strengths

- Clean modular structure.
- Role-based navigation and UI separation.
- Reusable components for common UI patterns.
- JSON-ready models for doctor and appointment data.
- Clear service layer for in-memory data handling and local persistence support.
- Easy to extend into a real production app. [file:8]

---

## Current Limitations

- Data is primarily in-memory in the current version.
- Some screens are placeholders or can be expanded further.
- Patient and User models are simple and can be improved with serialization if needed.
- Stronger backend authentication and persistent cloud storage are not yet implemented. [file:8]

---

## Future Enhancements

- Firebase or REST API backend integration.
- Persistent database for users, doctors, and appointments.
- Notification system for reminders and appointment updates.
- Appointment approval workflow for doctors or admins.
- Profile editing and password management.
- Analytics dashboard with charts and reporting.
- Secure authentication with encrypted storage. [file:8][web:3]

---

## License

This project is created for educational and demonstration purposes. Add your preferred license here before publishing to GitHub.

---

## Contributors

- Meet Patel
- Vishakha Parmar
- Yashvi Purohit
- Tanish Patel
- Man Prajapati
- Mahek Patel

---
