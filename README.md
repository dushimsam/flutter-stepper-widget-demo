# Stepper Widget

A basic demonstration project showcasing the **Stepper** widget functionality.

## What is a Stepper Widget?

We use this widget to progress through a sequence of steps. Such as:
- Multi-step forms
- Registration processes
- Checkout flows
- Onboarding experiences

## Features in the DEMO

- **Step Navigation**: Move forward/backward through steps
- **Step States**: Active, or completed
- **Form Components**: Text fields in each step
- **Validation**: Review and confirm data

## Run App Locally

### Prerequisites
- Flutter SDK
- An IDE such as (VS Code)

### Run the App

```bash
# Get dependencies
flutter pub get

# Run on your emulator
flutter run
```

## Structure of Code

```
lib/
  └── main.dart
```

## The Key Properties

- `currentStep`: The index of the current step
- `onStepContinue`: Callback when Continue button is pressed
- `onStepCancel`: Callback when Cancel button is pressed
- `onStepTapped`: Callback when a step is tapped
- `steps`: List of Step widgets to display

## Step Widget Properties

Each `Step` has:
- `title`: Step title (usually Text widget)
- `content`: Step content
- `isActive`: Whether the step is currently active
- `state`: StepState (indexed, complete, disabled, error, etc...)
