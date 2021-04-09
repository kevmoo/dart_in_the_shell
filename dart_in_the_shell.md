---
marp: true
theme: uncover
class:
  - invert
size: 16:9
paginate: true
#backgroundImage: url('https://marp.app/assets/hero-background.jpg')
---

# kevmoo Dart CLI Guide

Keeping track of CLI app best practices in one spot

---

# Use the exitCode setter

Calling `exit(...)` terminates your application immediately.

Not possible to debug your app or use observatory with "pause on exit".

```dart
import 'dart:io';

void main() {
    // DO!
    exitCode = 64;
    // Avoid!
    exit(64);
}
```

---

# Keep the contents of `bin/my_app.dart` tiny

This makes unit testing much easier.

```dart
// bin/my_app.dart

import 'package:my_app/src/entry_point.dart';

Future<void> main(List<String> arguments) async {
  await runApp(arguments);
}
```

---

# Only set `exitcode` in `by/my_app.dart`.

I'd argue package code should NEVER touch `exitCode`.

It makes tracking down which code is setting the exit code super hard.

Do it only in one place.

---

# Non-zero exit code on failure

A non-zero exit code means the process failed. If your app crashes with an
unhandled exception, a non-zero exit code is set automatically.

---

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

---

# Descriptive exit code if you can

- https://www.freebsd.org/cgi/man.cgi?query=sysexits
- https://pub.dev/documentation/io/latest/io/ExitCode-class.html

---

# TODO items

- pkg:stack_trace
- version info: pkg:build_version
- testing:
  - test on many OSes
  - pkg:test_descriptor
  - pkg:test_process
