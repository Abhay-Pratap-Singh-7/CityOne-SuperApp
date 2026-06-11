# 🏙️ CityOne SuperApp

A modern, comprehensive SuperApp built with **Flutter**. CityOne is designed to be a unified platform that integrates various services into a single, seamless user experience, including ride-hailing, activity tracking, notifications, and more!

---

## ✨ Key Features

- **🔐 Secure Authentication:** Seamless onboarding with Login, OTP Verification, and Registration.
- **🏠 Home Dashboard:** A centralized hub for accessing all SuperApp services.
- **🚗 Unified Transport Hub:** Integrated ride booking and transport management.
- **📋 Activity & Orders History:** Keep track of your past activities and orders easily.
- **🔔 Notification Hub:** Stay updated with real-time alerts and notifications.
- **👤 Profile Management:** Comprehensive user profile hub.
- **🧭 Advanced Routing:** Powered by `go_router` with stateful nested navigation (Bottom Navigation Bar) to seamlessly switch between features without losing state.

## 🛠️ Tech Stack

- **Framework:** [Flutter](https://flutter.dev/) (SDK ^3.11.5)
- **Language:** [Dart](https://dart.dev/)
- **Routing:** [`go_router`](https://pub.dev/packages/go_router)
- **UI/UX Enhancements:** `cupertino_icons`, `flutter_native_splash`, `flutter_launcher_icons`
- **Fonts:** Comfortaa, Fredoka

## 📁 Project Structure

The core of the application is located in the `lib/` directory:

```text
lib/
├── constants/        # App-wide constants (e.g., themes, colors)
├── router/           # Routing configuration (app_router.dart)
├── screens/          # Main application screens
│   ├── OnBoarding&Auth/  # Welcome, Login, OTP, Registration
│   ├── ride/             # Unified Transport Hub
│   └── ...               # Home, Activity, Notifications, Profile
├── widgets/          # Reusable UI components (e.g., main_shell)
└── main.dart         # Entry point of the application
```

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Version 3.11.5 or higher recommended)
- A compatible IDE (e.g., VS Code, Android Studio)
- An emulator or physical device for testing (iOS/Android)

### Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd cityoneapp
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## 🎨 Assets & Theming

- **Splash Screen:** Automatically generated via `flutter_native_splash`. Themed with a `#F9C123` background and the app logo.
- **App Icon:** Configured using `flutter_launcher_icons`.
- **Theme:** Custom defined `CityOneTheme.lightTheme` fully utilizing Material Design principles.

## 📱 Screenshots

> **Note:** Add your app screenshots to an `assets/screenshots/` directory and uncomment the table below to showcase your app.

<!--
| Home Dashboard | Transport Hub | Profile Hub |
|:---:|:---:|:---:|
| <img src="assets/screenshots/home.png" width="200"/> | <img src="assets/screenshots/ride.png" width="200"/> | <img src="assets/screenshots/profile.png" width="200"/> |
-->

---
*Built with ❤️ using Flutter.*
