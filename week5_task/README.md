# Flutter Firebase Authentication & Firestore  
### Week 5 – Internship Task

## 📖 Description
This project is developed as part of **Week 5 Internship Tasks**.  
The purpose of this app is to demonstrate **Firebase Authentication** and **Cloud Firestore integration** in a Flutter application.

The app allows users to:
- Sign up using Email & Password
- Log in securely
- View their profile after successful authentication
- Store and retrieve user data (name & email) from Cloud Firestore

---

## 🎯 Learning Objectives Covered
- Firebase setup and configuration in Flutter
- Email & Password Authentication using Firebase
- User Signup & Login workflow
- Cloud Firestore integration
- Storing and retrieving user data
- Clean architecture using models, services, and UI layers

---

## 🛠️ Technologies Used
- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- Material UI

---

## 📱 App Features
- Signup screen with form validation
- Login screen with form validation
- Firebase Email/Password Authentication
- Firestore database integration
- User profile screen after login
- Error handling and loading indicators
- Custom reusable widgets

---

## 🧩 Folder Structure
lib/
│── models/
│ └── user_model.dart
│
│── services/
│ ├── auth_service.dart
│ └── firestore_service.dart
│
│── screens/
│ ├── login_screen.dart
│ ├── signup_screen.dart
│ └── profile_screen.dart
│
│── widgets/
│ ├── custom_textfield.dart
│ └── custom_button.dart
│
│── main.dart



---

## ⚙️ Firebase Setup Instructions

Firebase was configured using **FlutterFire CLI**.

### Steps:
1. Create a Firebase project from **Firebase Console**
2. Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli


3. Login to Firebase:

firebase login

4. Configure Firebase for the Flutter project:

5. Enable the following services from Firebase Console:

Email/Password Authentication

Cloud Firestore Database

6. Run the project:

flutter pub get
flutter run
