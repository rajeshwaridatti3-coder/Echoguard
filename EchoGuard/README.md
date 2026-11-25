# EchoGuard – Intelligent Environmental Sound Detection

EchoGuard is an Android-first Flutter application for on-device environmental audio event recognition. It captures microphone audio, prepares mono PCM windows, runs a TensorFlow Lite YAMNet classifier, and stores recognized events locally.

## What it does
- Captures 16 kHz mono PCM audio after microphone permission is granted.
- Runs inference on 15,600-sample windows through a TFLite adapter.
- Displays recognized class labels and confidence scores.
- Stores event history in SQLite.
- Fails visibly when model assets are missing rather than generating fake AI results.

## Technology
Flutter · Dart · TensorFlow Lite · YAMNet · Riverpod · SQLite · Android microphone APIs

## Setup
1. Install Flutter and Android Studio.
2. Clone this repository and run `flutter pub get`.
3. Follow [`docs/MODEL_SETUP.md`](docs/MODEL_SETUP.md) to install the official YAMNet model and class map.
4. Run `flutter analyze` and `flutter test`.
5. Connect a physical Android device and run `flutter run`.

## Project structure
- `lib/core/services/` – audio capture and inference adapter
- `lib/core/data/` – local event persistence
- `lib/features/dashboard/` – monitoring dashboard
- `docs/` – model setup and device test plan

## Limitations
- The app currently performs foreground monitoring; reliable background listening is not implemented.
- Recognition is limited to classes supported by the selected YAMNet model.
- Model tensor compatibility and real-device performance must be verified with the exact downloaded model.
- It is a prototype, not a certified alarm, medical, or emergency warning system.
- No audio recordings are intentionally persisted; event metadata is stored locally.

## License
Add a license after reviewing the licenses of Flutter dependencies and the selected model.
