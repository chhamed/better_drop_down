# BetterDropDown

A customizable Flutter dropdown widget with enhanced UI, hover effects, and Material Design styling.
## Demo

**📱 Mobile Preview:**

![Screen Recording 2025-07-27 at 9 01 11 PM](https://github.com/user-attachments/assets/fce09ca9-b763-43f2-a9ae-2c0f7a0cd7d4)


**🖥️ Web Preview:**

![Screen Recording 2025-07-27 at 9 03 43 PM](https://github.com/user-attachments/assets/fd3407b1-c5ae-4c5a-b795-76b7e6e8a45b)


## Features
- Customizable hint text, icon, and dropdown color
- Smooth hover effects for menu items
- Material Design styling with elevation and border customization


## Installation
Add this to your `pubspec.yaml`:
```yaml
dependencies:
  better_drop_down: ^1.0.3
```

Then run:
```bash
flutter pub get
```

## Usage
```dart
import 'package:flutter/material.dart';
import 'package:better_drop_down/better_drop_down.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: BetterDropDown<String>(
            hintText: 'Select an option',
            value: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
              });
            },
            items: const [
              DropdownMenuItem(value: '1', child: Text('Option 1')),
              DropdownMenuItem(value: '2', child: Text('Option 2')),
              DropdownMenuItem(value: '3', child: Text('Option 3')),
            ],
          ),
        ),
      ),
    );
  }
}
```

## License
MIT License
