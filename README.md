# kRadio Player

![Logo](android/app/src/main/res/mipmap-hdpi/ic_launcher.png?raw=true)

Another Awesome Online Radio Player.

![Home screen](readme_assets/app.gif?raw=true)


## Getting Started

1. Follow the guide on how to [install Flutter](https://flutter.dev/docs/get-started/install).
2. Clone the repository and open with your IDE: [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)
3. Install IDE plugins for [Flutter support](https://flutter.dev/docs/get-started/editor?tab=androidstudio)
4. Create your own [Firebase project](https://console.firebase.google.com/)
5. Register apps with Firebase: [android](https://firebase.google.com/docs/android/setup#register-app) and [iOS](https://firebase.google.com/docs/ios/setup#register-app)
6. Add Firebase configuration files: [android](https://firebase.google.com/docs/android/setup#add-config-file) and [iOS](https://firebase.google.com/docs/ios/setup#add-config-file)
7. To download project dependencies execute: `flutter pub get`
8. Run project on Simulator or Android device

## Github actions: checks and deployment

- [Prerequisites](readme_assets/PREREQUISITES.md)
- Pull request checks
- Tests apps deployment
- 

## Architecture, libraries and tools

1. State management: [Bloc](https://bloclibrary.dev/#/)
2. Code style: [![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)

## Check code style

The project follows rules from [effective Dart](https://dart.dev/guides/language/effective-dart) to validate code locally run:

> dartanalyzer --options analysis_options.yaml ./lib
