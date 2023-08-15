# Signal Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][kac], and this project adheres to
[Semantic Versioning][semver].

[kac]: https://keepachangelog.com/en/1.1.0/
[semver]: https://semver.org/spec/v2.0.0.html

## [Unreleased]

## [0.1.0] - 2023-08-12

### Added

- `Signal` class for creating and managing signals
  - Connecting callbacks to signals
  - Firing signals
  - Disconnecting all callbacks from signals
  - Providing an `Event` object for external use
- `Event` class for externally connecting to signals
  - Connecting callbacks to events
- `Connection` objects for managing callbacks connected to signals/events
  - Disconnecting callbacks
  - Checking if callbacks are connected

[unreleased]: https://github.com/lasttalon/signal/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/lasttalon/signal/releases/tag/v0.1.0
