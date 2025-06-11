# Flutter Clean Architecture (Bloc) - Houzeo

Screen Recordings: https://drive.google.com/drive/folders/1fc-NRh0koBjBKg5avuV9aI5UpFGo-HZG?usp=share_link

![houzeo](https://github.com/user-attachments/assets/2643735c-2e74-41b6-a6f4-c6e96aafd491)

## Folder Structure
```bash
lib/
├── core/
│   ├── common/
│   │   ├── widgets/
│   ├── error/
│   ├── theme/
│   └── use_case/
│   └── utils/
├── features/
│   ├── feature/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── cubit/
│   │       ├── screens/
│   │       └── widgets/
└── main.dart
``` 

## Setup Instructions  
 1. Clone the repo:
```bash 
git clone https://github.com/Bhaveshupadhyay/houzeo_google_contact.git
cd flutter houzeo_google_contact
```
2. Install dependencies:
```bash 
flutter pub get
```
3. Run the app:
```bash 
flutter run
```


## Libraries Used
- flutter_screenutil
- flutter_bloc
- sqflite
- fpdart
- image_picker
- path
- permission_handler
- flutter_phone_direct_caller
- url_launcher
- intl_phone_field
- lottie
