# Flutter Clean Architecture (Bloc) - Houzeo

Screen Recordings: https://drive.google.com/drive/folders/1fc-NRh0koBjBKg5avuV9aI5UpFGo-HZG?usp=share_link
![houzeo](https://github.com/user-attachments/assets/f0a668fe-7e88-476d-9ae3-4300dc412ddd)


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

## Installation


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
