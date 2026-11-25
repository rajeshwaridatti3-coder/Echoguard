# 🔊 EchoGuard — Intelligent Environmental Sound Event Detection

**An AI-powered environmental sound monitoring application built with Flutter, TensorFlow Lite, and on-device audio processing.**

EchoGuard is designed to identify and classify environmental sounds from live microphone input, transforming raw audio signals into meaningful sound events. It aims to provide an intelligent monitoring experience by detecting sounds such as alarms, sirens, vehicle horns, dog barks, and other environmental audio events.

The project combines mobile application development, machine learning integration, audio signal processing, and local data persistence to demonstrate how edge AI can be used for real-world sound intelligence.

---

## 🚀 Project Highlights

- **AI-Based Sound Classification:** Designed to integrate a YAMNet TensorFlow Lite model for environmental sound recognition.
- **Live Audio Monitoring:** Captures microphone audio streams for continuous sound analysis while monitoring is active.
- **Edge AI Architecture:** Designed for on-device inference, reducing dependence on cloud-based processing.
- **Sound Event Logging:** Stores detected sound events locally using SQLite.
- **Real-Time Monitoring Dashboard:** Provides a central interface for controlling monitoring and viewing recent sound events.
- **Modular Architecture:** Separates audio monitoring, classification, event management, and presentation logic.
- **Privacy-Oriented Design:** Audio processing is intended to take place locally rather than requiring continuous audio uploads to a server.

## 🧠 How It Works

EchoGuard follows an audio-processing pipeline that transforms microphone input into classified sound events.

```text
       Microphone Input
              |
              v
       Audio Stream Capture
              |
              v
       Audio Preprocessing
              |
              v
       TensorFlow Lite Model
           (YAMNet)
              |
              v
       Sound Classification
              |
              v
       Event Generation
              |
              v
       SQLite Event Storage
              |
              v
       Flutter Dashboard
```

### Sound Detection Pipeline

1. **Audio Capture:** The application captures audio from the device microphone.
2. **Preprocessing:** Audio samples are prepared in the format expected by the classification model.
3. **Model Inference:** The TensorFlow Lite integration is designed to run YAMNet inference on audio samples.
4. **Classification:** Model predictions can be mapped to environmental sound categories.
5. **Event Management:** Classification results can be represented as structured sound events.
6. **Local Persistence:** Event records are stored in an SQLite database.
7. **Visualization:** The dashboard displays recent sound events for monitoring.

*Note: The current source package contains the model integration adapter, not the trained YAMNet model binary. Actual classification requires adding the model and validating its input/output tensors.*

---

## 🛠️ Technology Stack

| Category | Technologies |
|---|---|
| Mobile Development | Flutter, Dart |
| State Management | Riverpod |
| Machine Learning | TensorFlow Lite, YAMNet integration |
| Audio Processing | Microphone audio streaming, PCM |
| Database | SQLite |
| Platform | Android |
| Architecture | Modular service-based architecture |
| Development Tools | Android Studio, VS Code, Git, GitHub |

## 📂 Project Structure

```text
EchoGuard/
│
├── android/
│   └── app/
│       └── src/main/
│           └── AndroidManifest.xml
│
├── lib/
│   ├── main.dart
│   ├── app.dart
│   │
│   ├── core/
│   │   ├── data/
│   │   │   └── event_database.dart
│   │   │
│   │   ├── models/
│   │   │   └── sound_event.dart
│   │   │
│   │   └── services/
│   │       ├── monitor_service.dart
│   │       └── sound_classifier.dart
│   │
│   └── features/
│       └── dashboard/
│           └── dashboard_screen.dart
│
├── docs/
│   ├── MODEL_SETUP.md
│   └── TEST_PLAN.md
│
├── test/
│   └── widget_test.dart
│
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
