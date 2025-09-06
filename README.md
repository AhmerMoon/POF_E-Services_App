# POF e-Services 🚀

<div align="center">
  
![POF e-Services](https://img.shields.io/badge/Flutter-Framework-blue?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Backend-orange?logo=firebase)
![Platform](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web-green)
![License](https://img.shields.io/badge/License-Proprietary-lightgrey)

A comprehensive Flutter-based employee services application for Pakistan Ordnance Factories (POF) employees.

</div>

## 📸 Application Screenshots
<div align="center">
Splash Screen
<img src="screenshots/splash_screen.jpeg" width="200" alt="Splash Screen - Welcome animation with POF branding"> *Welcome animation with POF branding*
Login Screen
<img src="screenshots/login_screen.jpeg" width="200" alt="Login Screen - Secure authentication interface"> *Secure authentication interface*
Login Instructions
<img src="screenshots/login_instructions_screen.jpeg" width="200" alt="Login Instructions - Step-by-step guide for account access"> *Step-by-step guide for account access*
Home Screen
<img src="screenshots/home_screeen.jpeg" width="200" alt="Home Screen - Main dashboard with service grid"> *Main dashboard with service grid*
Complaints Overview
<img src="screenshots/complaints_screen.jpeg" width="200" alt="Complaints Screen - Complaint management dashboard"> *Complaint management dashboard*
CMA/Pay Slips
<img src="screenshots/cma_screen.png" width="200" alt="CMA Screen - Pay slip management and download"> *Pay slip management and download*
Change Password
<img src="screenshots/change_password_screen.jpeg" width="200" alt="Change Password Screen - Secure password update interface"> *Secure password update interface*

</div>

## ✨ Features

### 🔐 Authentication & Security
- **Secure Login System** with Firebase Authentication
- **Password Management** with change password functionality
- **Role-based Access Control**

### 📋 Complaint Management System
- 🆕 **Register New Complaints** with multiple categories
- 👀 **View Open Complaints** with real-time updates
- ✅ **Track Closed Complaints** with timestamps
- 📊 **Complaint Statistics** dashboard

### 💰 Payroll Services
- 📄 **Pay Slip Generation** for last 12 months
- 🌐 **Cross-platform PDF Export** (web and mobile)
- ⬇️ **Easy Download** functionality

### 🏢 Service Categories
- 🔧 Station Engineer Services
- 📞 Telephone & Internet Services
- 💧 Water Supply Management
- 📊 CMA (POFs) Services
- 🚌 Student Bus Pass
- 🎓 POF Merit Scholarship
- ⚡ Electric Distribution
- 🎯 GCC Training

## 📱 Screens Overview

| | | |
|:-------------------------:|:-------------------------:|:-------------------------:|
| **Splash Screen**<br>*Welcome animation* | **Login Screen**<br>*Secure authentication* | **Home Screen**<br>*Service dashboard* |
| **Complaint Registration**<br>*Multi-step form* | **Complaint Tracking**<br>*Real-time status* | **Pay Slips**<br>*PDF generation* |

## 🛠️ Technology Stack

- **Frontend Framework**: Flutter 📱
- **Backend Services**: Firebase 🔥
- **Authentication**: Firebase Auth 🔐
- **Database**: Cloud Firestore 💾
- **State Management**: Provider 🧩
- **PDF Generation**: pdf & printing packages 📄
- **File Management**: path_provider 📁

## 🚀 Installation & Setup

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Firebase project
- Android/iOS development environment

### Step-by-Step Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd pof_e_services
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration**
   - Create a new Firebase project
   - Enable Authentication (Email/Password)
   - Enable Firestore Database
   - Add platform configurations:
     - Android: Add `google-services.json`
     - iOS: Add `GoogleService-Info.plist`
     - Web: Add Firebase config to `web/index.html`

4. **Run the application**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── screens/
│   ├── splash_screen.dart      # Welcome animation
│   ├── login_screen.dart       # Authentication
│   ├── home_screen.dart        # Main dashboard
│   ├── complaint_screen.dart   # Complaint management
│   ├── register_complaint_screen.dart  # New complaint
│   ├── open_complaints_screen.dart     # Active complaints
│   ├── closed_complaints_screen.dart   # Resolved complaints
│   ├── cma_screen.dart         # Pay slip management
│   └── change_password_screen.dart     # Security
├── services/
│   └── auth_service.dart       # Authentication logic
└── main.dart                   # App entry point
```

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter | SDK | UI Framework |
| firebase_core | ^4.0.0 | Firebase integration |
| firebase_auth | ^6.0.1 | Authentication |
| cloud_firestore | ^6.0.0 | Database |
| provider | ^6.1.5+1 | State management |
| pdf | ^3.11.3 | PDF generation |
| printing | ^5.14.2 | PDF printing |
| path_provider | ^2.1.5 | File system access |

## 🏗️ Building for Production

### Android APK
```bash
flutter build apk --release
```

### iOS Bundle
```bash
flutter build ios --release
```

### Web Deployment
```bash
flutter build web --release
```

## 🤝 Contributing

We welcome contributions to enhance POF e-Services! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is developed for and owned by Pakistan Ordnance Factories. All rights reserved.

## 🆘 Support

For technical support or questions about this application, please contact:
  
📧 ahmermoonmajid@gmail.com  
☎️ +92-328-5077511

---

<div align="center">

### **Powered By: IT Department - POF**

*Enhancing employee services through technology* ✨

</div>
