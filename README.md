---
marp: true
theme: uncover
class:
  - invert
size: 16:9
paginate: true
headingDivider: 1
---

# kevmoo Dart CLI Guide

Keeping track of CLI app best practices in one spot

# Use the exitCode setter

<!-- footer: kevmoo@ -->

- Calling `exit(...)` terminates your application immediately.
- Not possible to debug your app or use observatory with "pause on exit".

```dart
import 'dart:io';
void main() {
    exitCode = 64; // DO!
    exit(64);      // Avoid!
}
```

# Keep the contents of `bin/my_app.dart` tiny

This makes unit testing much easier.

```dart
// bin/my_app.dart

import 'package:my_app/src/entry_point.dart';

Future<void> main(List<String> arguments) async {
  await runApp(arguments);
}
```

# Only set `exitcode` in `bin/my_app.dart`.

- Code in `lib/` should NEVER touch `exitCode`.
- Makes tracking down which code is setting the exit code super hard.
- Do it only in one place.

# Non-zero exit code on failure

- A non-zero exit code means the process failed.
- If your app crashes with an unhandled exception, a non-zero exit code is set
  automatically.

# Example: Non-zero exit code

```dart
// bin/my_app.dart

import 'package:my_app/src/entry_point.dart';

Future<void> main(List<String> arguments) async {
  try {
    await runApp(arguments);
  } catch (e, stack) {
    print('App crashed!');
    print(e);
    print(stack);
    exitCode = 1;
  }
}
```

# Descriptive exit code if you can

- https://www.freebsd.org/cgi/man.cgi?query=sysexits
- https://pub.dev/documentation/io/latest/io/ExitCode-class.html
- Be a good \*nix citizen
- Examples: `64` - bad usage, `78` - bad configuration

# TODO items

- pkg:stack_trace
- version info: pkg:build_version

# TODO arg parsing

- pkg:args
- pkg:build_cli
- pkg:completion

# TODO configuration

- pkg:json_serializable
- pkg:yaml
- pkg:checked_yaml

# TODO testing

- test on many OSes
- pkg:test_descriptor
- pkg:test_process
- test your README!

# TODO: networking

- close your HTTP clients in finally block
- Set your user-agent header!
  - include version info
  - help with debugging issues in the wild

# TODO: conventions

- write cached files to `.dart_tool/[pkg_name]`

# TODO: make things pretty!

- pkg:io for ansi

# TODO: distribution

- pub global activate
- AOT pre-compile? Hrm...

# TODO: auth

- storing credentials, redirecting the user, etc etc

examples in Dart

- pub client
- googleapis_auth package
