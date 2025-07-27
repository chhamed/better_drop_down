library drop_down_plus;

import 'package:flutter/material.dart';

/// A customizable dropdown widget with enhanced UI, hover effects, and Material Design styling.
///
/// This widget provides a dropdown menu with a clean, modern appearance, supporting
/// features like custom hint text, icons, dropdown color, elevation, and maximum menu height.
/// It uses an [OverlayEntry] to display the dropdown menu below the input field and includes
/// hover effects for better user interaction.
class DropDownPlus extends StatefulWidget {
  /// The currently selected value of the dropdown.
  /// If null, the [hintText] is displayed.
  final String? value;

  /// Callback triggered when the selected value changes.
  /// Provides the newly selected value or null if no value is selected.
  final ValueChanged<String?> onChanged;

  /// List of dropdown menu items to display.
  /// Each item must be a [DropdownMenuItem<String>] with a value and child widget.
  final List<DropdownMenuItem<String>> items;

  /// Optional hint text to display when no value is selected.
  final String? hintText;

  /// Optional icon to display at the end of the dropdown.
  /// Defaults to a downward arrow icon if not provided.
  final Widget? icon;

  /// Optional background color for the dropdown menu.
  /// Defaults to white if not provided.
  final Color? dropdownColor;

  /// Elevation of the dropdown menu.
  /// Controls the shadow depth of the menu. Defaults to 8.0.
  final double elevation;

  /// Optional text style for the dropdown items and hint text.
  final TextStyle? style;

  /// Optional maximum height of the dropdown menu.
  /// Constrains the menu height to prevent it from growing too large. Defaults to 300.
  final double? menuMaxHeight;

  const DropDownPlus({
    Key? key,
    this.value,
    required this.onChanged,
    required this.items,
    this.hintText,
    this.icon,
    this.dropdownColor,
    this.elevation = 8.0,
    this.style,
    this.menuMaxHeight,
  }) : super(key: key);

  @override
  DropDownPlusState createState() => DropDownPlusState();
}

/// The state class for [DropDownPlus], managing the dropdown's open/closed state and overlay.
class DropDownPlusState extends State<DropDownPlus> {
  /// The overlay entry used to display the dropdown menu.
  OverlayEntry? _overlayEntry;

  /// Tracks whether the dropdown menu is open.
  bool _isOpen = false;

  /// Tracks the currently hovered item's value for hover effects.
  String? _hoveredValue;

  /// Toggles the dropdown menu between open and closed states.
  void _toggleDropdown() {
    if (_isOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() => _isOpen = !_isOpen);
  }

  /// Creates an [OverlayEntry] for the dropdown menu.
  ///
  /// Positions the menu below the dropdown widget and populates it with [widget.items].
  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    var size = renderBox?.size;
    var offset = renderBox?.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => StatefulBuilder(
        builder: (context, overlaySetState) => GestureDetector(
          onTap: () => _toggleDropdown(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  left: offset?.dx,
                  top: (offset?.dy ?? 0) + (size?.height ?? 0),
                  width: size?.width,
                  child: GestureDetector(
                    onTap: () {},
                    child: Material(
                      elevation: widget.elevation,
                      child: Container(
                        color: widget.dropdownColor ?? Colors.white,
                        constraints: BoxConstraints(maxHeight: widget.menuMaxHeight ?? 300),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: widget.items.map((DropdownMenuItem<String> item) {
                            final isHovered = _hoveredValue == item.value;
                            return MouseRegion(
                              onEnter: (_) {
                                _hoveredValue = item.value;
                                overlaySetState(() {});
                              },
                              onExit: (_) {
                                _hoveredValue = null;
                                overlaySetState(() {});
                              },
                              child: GestureDetector(
                                onTap: () {
                                  widget.onChanged(item.value);
                                  _toggleDropdown();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  color: widget.value == item.value
                                      ? Colors.grey[200]
                                      : isHovered
                                          ? Colors.grey[100]
                                          : null,
                                  child: item.child,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Cleans up the overlay when the widget is disposed.
  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  /// Builds the dropdown widget with a styled [InputDecorator] and toggle functionality.
  @override
  Widget build(BuildContext context) {
    const effectiveDecoration = InputDecoration();
    final effectiveHint = widget.hintText != null
        ? Text(
            widget.hintText!,
            style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w400),
          )
        : null;
    final effectiveIcon = widget.icon ?? Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Colors.grey[600]);

    return GestureDetector(
      onTap: _toggleDropdown,
      child: InputDecorator(
        decoration: effectiveDecoration.copyWith(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: widget.value != null ? widget.items.firstWhere((item) => item.value == widget.value, orElse: () => widget.items.first).child : effectiveHint ?? const SizedBox.shrink()),
            effectiveIcon,
          ],
        ),
      ),
    );
  }
}
