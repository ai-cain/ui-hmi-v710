# UiHmiV710

`UiHmiV710` is a Qt 6 / QML human-machine interface project for CrossControl-style displays and embedded targets. The repository contains the main application, reusable QML components, backend objects exposed to QML, and hardware-facing handlers for features such as backlight, buzzer, front LED, power configuration, and version reporting.

## Overview

The application is built as a single root Qt Quick target:

- Project name: `UiHmiV710`
- Executable target: `appUiHmiV710`
- UI technology: Qt Quick / QML
- Language: C++
- Build system: CMake

The current desktop UI is designed around an `800x480` layout and includes the main navigation areas:

- `Setup`
- `Diagnostic`
- `Connection`
- `Info`

The project also includes:

- an integrated app clock exposed from C++ to QML
- an integrated on-screen keyboard for touch-first workflows
- desktop preview capability on Windows for UI work
- Linux / CrossControl integration paths for real hardware features

## Repository Layout

```text
ui-hmi-v710/
├── backend/         C++ backend objects exposed to QML
├── CCAux/           Hardware/device feature handlers
├── components/      Reusable QML building blocks
├── components/keyboard/
├── graphics/        Icons and image assets
├── pages/
│   ├── sections/    Menu section containers
│   └── features/    Feature and placeholder pages
├── CMakeLists.txt   Root build definition
├── main.cpp         Application bootstrap and context setup
├── main.qml         Root window and navigation shell
├── qml.qrc          QML/resource bundle
└── README.md
```

## Main Source Areas

### `backend/`

Contains the core application-facing C++ objects used by the QML layer.

Important files include:

- `backend/backend.*` for application/system data exposed to QML
- `backend/displayConfigHandler.*` for display identification/orientation-related logic
- `backend/hwbutton.*` for hardware button handling
- `backend/Clock.*` for the app clock integrated into the current UI
- `backend/KeyEmitter.h` for keyboard-related event plumbing

### `CCAux/`

Contains handlers for device-level features:

- `BackLightHandler`
- `BuzzerHandler`
- `FrontLedHandler`
- `PowerConfigHandler`
- `VersionHandler`

These handlers are the most hardware-dependent part of the project.

### `components/`

Reusable QML controls and shared pieces of UI, including:

- page headers/titles
- sliders and toggle controls
- info/status widgets
- the date/time editing dialog
- the integrated touch keyboard in `components/keyboard/`

### `pages/`

The QML pages are now split by responsibility:

- `pages/sections/` for top-level menu containers such as setup, diagnostic, connection, and info
- `pages/features/` for the actual feature screens and shared placeholders

Feature pages include:

- system setup
- backlight
- front LED
- date and time
- orientation
- touch diagnostics
- version information

## Requirements

Minimum development requirements:

- Qt `6.4` or newer
- CMake `3.16` or newer
- Qt Quick / QML modules
- A working Qt Creator kit or command-line CMake toolchain

For full device integration you will also need:

- a Linux environment, CrossControl VM, or target device
- CrossControl headers in `/opt/crosscontrol/include`
- CrossControl libraries available under `/opt/crosscontrol/...`

## Build Notes

### Desktop preview on Windows

You can open and work with the project in Qt Creator on Windows for UI development and desktop preview. This is useful for:

- navigation work
- QML layout adjustments
- visual cleanup
- touch keyboard and clock UI integration

Some hardware-dependent features will not behave the same as on the real device.

### Full hardware behavior

Real hardware support depends on Linux-specific APIs and CrossControl libraries. For example:

- hardware buttons use Linux input APIs
- some handlers expect CrossControl runtime libraries
- target-specific behavior changes between desktop and embedded environments

## Opening In Qt Creator

1. Open the repository folder or `CMakeLists.txt` in Qt Creator.
2. Choose a Qt 6 kit.
3. Configure the project.
4. Build and run `appUiHmiV710`.

Notes:

- Do not use `Import Build From...` unless you actually have a previous compatible build directory.
- If Qt Creator keeps stale CMake state, remove the old build directory and configure again.

## Building From The Command Line

Example:

```powershell
cmake -S . -B build
cmake --build build
```

If Qt is not found, make sure your Qt installation is available to CMake, for example through your Qt Creator kit or `CMAKE_PREFIX_PATH`.

## Runtime Notes

At startup, `main.cpp` creates the backend objects and exposes them to QML through the application engine context. The root QML file is loaded from:

```text
qrc:/UiHmiV710/main.qml
```

The app currently mixes:

- desktop-friendly preview behavior
- embedded/hardware-specific integration

That is expected for this codebase.

## Current Status

The repository has already been cleaned up from a number of old demos and duplicate modules. The current active codebase now treats the following as first-class parts of the app:

- the clock
- the on-screen keyboard
- the root HMI navigation
- the hardware feature pages

This means the repo is now much closer to a single main application instead of a collection of disconnected experiments.

## Known Limitations

- Some section pages can still be grouped into subfolders for an even cleaner structure.
- Some handlers are tightly coupled to real hardware/runtime availability.
- A desktop run is useful for UI work, but not a full replacement for testing on the target device.

## Recommended Next Cleanup Steps

- rename generic pages to feature-based names
- keep separating UI concerns from hardware/device concerns
- continue tightening QML warnings and runtime null-safety
- validate hardware-facing behavior in the real Linux/CrossControl environment

## License / Ownership

This repository contains code and structure related to CrossControl-style device workflows.

No repository-wide open-source license is declared here.

Some files in this repository include third-party copyright notices, and the
build also links against vendor-provided libraries such as `cc-aux2`. Do not
assume that the entire repository is covered by LGPL or by any other single
license just because one shipped dependency may be LGPL-licensed.

For the current project note about `CCAux`, `cc-aux2`, redistribution, and the
LGPLv2.1 obligations that may apply when shipping that library, see
`THIRD_PARTY_NOTICES.md`.

If you distribute an LGPL-covered `cc-aux2` build with the app, include a copy
of the license text from `licenses/LGPL-2.1.txt` and follow the checklist in
`THIRD_PARTY_NOTICES.md`.
