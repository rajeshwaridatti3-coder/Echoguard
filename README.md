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
```

## ⚙️ Getting Started

### Prerequisites

Install the following tools:

- Flutter SDK
- Dart SDK (included with Flutter)
- Android Studio or Visual Studio Code
- Android device or emulator
- Git

Verify your Flutter installation:

```bash
flutter doctor
```

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/rajeshwaridatti3-coder/Echoguard.git
```

**2. Navigate to the project**

```bash
cd Echoguard
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Configure the machine learning model**

Follow the instructions in:

```text
docs/MODEL_SETUP.md
```

The expected model location is:

```text
assets/models/yamnet.tflite
```

The corresponding class map is expected at:

```text
assets/labels/yamnet_class_map.csv
```

Ensure that the model files are correctly configured in the Flutter assets and that the model's actual tensor dimensions and output format match the classifier implementation.

**5. Run the application**

Connect an Android device with USB debugging enabled, or start an emulator.

```bash
flutter run
```

---

## 🔬 Machine Learning Integration

EchoGuard is designed around **YAMNet**, a deep-learning model for classifying environmental audio events.

The intended integration uses:

- Audio waveform input.
- 16 kHz mono audio sampling.
- Fixed-size audio windows.
- TensorFlow Lite model inference.
- Classification scores mapped to sound categories.

The current classifier service provides the integration boundary for model inference. The model binary and class mapping must be added separately and validated before real-world classification can be considered operational.

## 🗄️ Local Data Management

EchoGuard uses SQLite for local sound-event persistence.

The event data layer is designed to support:

- Recording detected sound events.
- Retrieving recent event history.
- Maintaining structured event information.
- Supporting future filtering and analytics.

## 🔐 Privacy and Security

- Microphone access requires Android permission.
- Audio monitoring is initiated by the application.
- The intended inference architecture is on-device.
- Event history is stored locally.
- No cloud audio-upload backend is included in the current implementation.

## 🧪 Testing and Validation

The repository includes a test plan in `docs/TEST_PLAN.md`.

Important validation areas include:

- Microphone permission handling.
- Audio stream initialization and shutdown.
- Audio preprocessing correctness.
- TensorFlow Lite model loading.
- Model input/output tensor compatibility.
- Classification accuracy against labelled audio samples.
- SQLite event persistence.
- Dashboard behaviour and error handling.

## 🚧 Current Development Status

The repository currently provides the Flutter application foundation, monitoring service, event database, dashboard, and TensorFlow Lite classifier adapter.

The following work is required before describing EchoGuard as a fully operational sound-recognition application:

- Add the YAMNet model binary and class map.
- Validate model tensor dimensions and preprocessing.
- Complete and test end-to-end inference.
- Verify classification accuracy using labelled audio samples.
- Test microphone monitoring on physical Android devices.
- Validate long-running monitoring and resource usage.

## 🔮 Future Enhancements

- Background sound monitoring using Android foreground services.
- Custom sound-category training and fine-tuning.
- Confidence-based detection thresholds.
- Detection history analytics and visualizations.
- Configurable sound-category alerts.
- Event filtering and search.
- Exportable sound-event reports.
- Battery and inference-performance optimization.
- Support for additional on-device audio models.

## 🎯 Project Objective

EchoGuard explores the intersection of **Artificial Intelligence, Edge Computing, Audio Signal Processing, and Mobile Application Development**.

It demonstrates an architecture for converting environmental audio into structured, locally stored intelligence while providing a foundation for more advanced real-time sound monitoring applications.

---

## 👩‍💻 Author

**Rajeshwari Datti**

GitHub: [@rajeshwaridatti3-coder](https://github.com/rajeshwaridatti3-coder)

## 📜 License

This project is intended for educational, research, and portfolio purposes. Add a `LICENSE` file before distributing it under a specific open-source license.
