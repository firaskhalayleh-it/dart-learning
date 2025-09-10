# 01 – Environment Setup

## Goals
- Install Flutter & Dart toolchain
- Configure IDE (VS Code) & extensions
- Understand project structure & `pubspec.yaml`
- Run a sample app on emulator & device

## Steps
1. Install Flutter (macOS):
```
brew install --cask flutter
flutter doctor
```
2. Accept any Xcode / Android Studio requirements.
3. Enable web (optional): `flutter config --enable-web`.
4. Create a playground project:
```
flutter create sandbox_app
cd sandbox_app
flutter run
```
5. Open in VS Code; install extensions: Flutter, Dart.
6. Set up recommended launch configurations (auto-created).

## Key Files (Flutter project)
- `lib/main.dart` – entrypoint
- `pubspec.yaml` – dependencies, assets
- `analysis_options.yaml` – lints
- `android/`, `ios/`, `web/` – platform shells

## Pubspec Minimal Example
```yaml
name: sandbox_app
description: Environment setup practice
publish_to: 'none'
version: 0.1.0
environment:
  sdk: '>=3.2.0 <4.0.0'
dependencies:
  flutter:
    sdk: flutter
dev_dependencies:
  flutter_test:
    sdk: flutter
  lints: ^5.0.0
```

## Verification Checklist
- [ ] `flutter doctor` shows no unresolved issues
- [ ] Hot reload works
- [ ] Emulator & physical device both run app

## Practice Tasks
- Add an app icon (iOS & Android) using `flutter_launcher_icons` (research yourself).
- Enable web and open the app in Chrome.
- Create a second project named `taskmate_app` to evolve later.

## Next
Proceed to 02 for Dart language basics before heavy Flutter UI work.
