# EchoGuard model setup

EchoGuard uses the YAMNet audio event classifier. The model is intentionally not replaced with fake predictions.

## Required model assets

Place these files in the following locations:

- `assets/models/yamnet.tflite`
- `assets/labels/yamnet_class_map.csv`

Download the official TensorFlow Lite YAMNet model and class map from the TensorFlow Hub YAMNet model page:
https://tfhub.dev/google/lite-model/yamnet/tflite/1

Use the model variant compatible with TensorFlow Lite. Keep the original class-map CSV header and class ordering.

## Input contract

- Mono audio
- 16,000 samples per second
- 15,600 Float32 samples per inference window (~0.975 seconds)
- PCM values normalized to [-1, 1]

The current adapter reads the first model output tensor and selects its highest-scoring class. Verify the model's tensor shape and output semantics against the downloaded model version before production use.

## Important

The project does not include the model binary because model distribution terms and upstream versioning should be checked by the developer. Until both assets are installed, the app reports that model setup is required and does not fabricate detections.
