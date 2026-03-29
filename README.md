# ui-hmi-v710

Qt/QML-based HMI project for CrossControl-style devices and demos.

## Overview

This repository contains the main HMI application, device-facing backend code,
QML pages/components, and hardware-related handlers built around Qt 6, QML,
C++, and CMake.

## Current Status

- The main application lives in the repository root.
- `clock/` and `keyboard/` were moved to `legacy/` as archived modules/demos.
- Some paths and references may still need to be reconnected after that move.

## Project Structure

- `backend/`: backend logic, IP polling, display detection, hardware buttons.
- `CCAux/`: handlers for device features such as backlight, buzzer, front LED,
  power config, and version info.
- `components/`: shared QML UI building blocks.
- `pages/`: top-level and feature pages used by the HMI.
- `graphics/`: icons and image assets.
- `js/`: small JavaScript helpers.
- `others/`: experimental or auxiliary C++ code.
- `legacy/clock/`: archived clock-related standalone/demo code.
- `legacy/keyboard/`: archived keyboard-related standalone/demo code.

## Requirements

- Qt 6.4 or newer
- Qt Quick / QML
- CMake 3.16 or newer
- Linux/CrossControl-style environment for full hardware integration
- External CrossControl libraries available under `/opt/crosscontrol` for the
  target environment

## Notes

- This project is not currently plug-and-play on a standard Windows setup.
- Some features depend on hardware-specific libraries and Linux device access.
- The root app should be treated as the primary target; legacy modules are kept
  for reference until the migration is fully cleaned up.

## Next Step

Reconnect and update the remaining imports, build paths, and references after
the move to `legacy/`.
