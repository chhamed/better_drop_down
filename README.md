# DropDownPlus

A customizable Flutter dropdown widget with enhanced UI, hover effects, and Material Design styling.

## Features
- Customizable hint text, icon, and dropdown color
- Smooth hover effects for menu items
- Material Design styling with elevation and border customization
- Supports dynamic menu height and item selection

## Installation
Add this to your `pubspec.yaml`:
```yaml
dependencies:
  drop_down_plus: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## Usage
```dart
import 'package:flutter/material.dart';
import 'package:drop_down_plus/drop_down_plus.dart';

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
          child: DropDownPlus<String>(
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