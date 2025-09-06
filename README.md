# POF e-Services

A comprehensive Flutter-based employee services application for Pakistan Ordnance Factories (POF) employees.

# Video Tutorial

[🎥 Watch the demo](tutorial/tutorial.mp4)

## Features

- **User Authentication**: Secure login system with Firebase Authentication
- **Complaint Management**: 
  - Register new complaints with multiple categories
  - View open and closed complaints
  - Track complaint status with timestamps
- **Payroll Services**: 
  - Download pay slips for the last 12 months
  - Cross-platform PDF generation (web and mobile)
- **Password Management**: Secure password change functionality
- **Multiple Service Categories**:
  - Station Engineer
  - Telephone Internet
  - Water Supply
  - CMA (POFs)
  - Student Bus Pass
  - POF Merit Scholarship
  - Electric Distribution
  - GCC Training

## Screens

- Splash Screen
- Login Screen with instructions
- Home Screen with service grid
- Complaint Registration Screen
- Open Complaints Screen
- Closed Complaints Screen
- CMA (Pay Slips) Screen
- Change Password Screen

## Technologies Used

- **Flutter**: Cross-platform framework
- **Firebase**: 
  - Authentication for user management
  - Firestore for complaint data storage
- **PDF Generation**: For pay slip creation
- **Provider**: State management

## Setup Instructions

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Firebase project
- Android/iOS development environment (for mobile builds)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd pof_e_services
```

2. Install dependencies:
```bash
flutter pub get
```

3. Firebase Setup:
   - Create a new Firebase project
   - Enable Authentication (Email/Password)
   - Enable Firestore Database
   - Add your platforms (Android, iOS, Web)
   - Download configuration files and place them in the appropriate directories

4. Run the application:
```bash
flutter run
```

## Firebase Configuration

The app uses Firebase for:
- User authentication
- Cloud Firestore for complaint data storage

Make sure to configure Firebase properly for all target platforms (web, Android, iOS).

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Project Structure

```
lib/
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── complaint_screen.dart
│   ├── register_complaint_screen.dart
│   ├── open_complaints_screen.dart
│   ├── closed_complaints_screen.dart
│   ├── cma_screen.dart
│   └── change_password_screen.dart
├── services/
│   └── auth_service.dart
└── main.dart
```

## Dependencies

Key dependencies include:
- firebase_core: ^4.0.0
- firebase_auth: ^6.0.1
- cloud_firestore: ^6.0.0
- provider: ^6.1.5+1
- pdf: ^3.11.3
- printing: ^5.14.2
- path_provider: ^2.1.5

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on all platforms
5. Submit a pull request

## License

This project is developed for Pakistan Ordnance Factories. All rights reserved.

## Support

For support regarding this application, please contact the IT Department - POF.
