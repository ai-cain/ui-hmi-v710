# ui-hmi-v710

Qt/QML-based HMI project for CrossControl-style devices and demos.

## Overview

This repository contains the main HMI application, device-facing backend code,
QML pages/components, and hardware-related handlers built around Qt 6, QML,
C++, and CMake.

## Current Status

- The main application lives in the repository root.
- The integrated app clock now lives in `backend/Clock.*`.
- The integrated on-screen keyboard now lives in `components/keyboard/`.

## Project Structure

- `backend/`: backend logic, IP polling, display detection, hardware buttons.
- `backend/Clock.*`: app clock logic exposed to QML.
- `CCAux/`: handlers for device features such as backlight, buzzer, front LED,
  power config, and version info.
- `components/`: shared QML UI building blocks.
- `components/keyboard/`: reusable on-screen keyboard components.
- `pages/`: top-level and feature pages used by the HMI.
- `graphics/`: icons and image assets.

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
- The root app should be treated as the primary target.
