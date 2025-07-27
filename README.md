# BetterDropDown

A customizable Flutter dropdown widget with enhanced UI, hover effects, and Material Design styling.
## Demo
## 📱 Mobile Preview:

![Mobile Preview](https://raw.githubusercontent.com/your-username/your-repo-name/main/assets/mobile_preview.gif)

## 🖥️ Web Preview:

![Web Preview](https://raw.githubusercontent.com/your-username/your-repo-name/main/assets/web_preview.gif)

## Features
- Customizable hint text, icon, and dropdown color
- Smooth hover effects for menu items
- Material Design styling with elevation and border customization


## Installation
Add this to your `pubspec.yaml`:
```yaml
dependencies:
  better_drop_down: ^1.0.4
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
