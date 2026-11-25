# EchoGuard test plan

## Unit / integration checks
- Database creates its events table and stores/retrieves events.
- Sound classifier rejects input windows with an invalid sample count.
- Model initialization fails visibly when model assets are absent.
- Microphone permission denial prevents recording.
- Monitoring can be started and stopped without leaving an active recorder.

## Device checks
- Test on a physical Android device with microphone permission granted.
- Verify PCM stream sample rate and channel count.
- Validate predictions against the YAMNet class map.
- Test quiet and noisy environments.
- Check repeated-event behavior and battery usage.
- Verify the app does not claim emergency-grade detection.

## Acceptance criteria
- No fabricated classifications when model assets are missing.
- Events are persisted locally.
- User can stop microphone monitoring.
- Permission and model failures are visible to the user.
