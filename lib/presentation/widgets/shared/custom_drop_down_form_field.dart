import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  final T? value;
  final String labelText;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final TextStyle? labelStyle;
  final TextStyle? inputTextStyle;
  final TextStyle? dropdownTextStyle;

  const CustomDropdownFormField({
    super.key,
    required this.value,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.labelStyle,
    this.inputTextStyle,
    this.dropdownTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: inputTextStyle,
      items: items,
      onChanged: onChanged,
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).canvasColor,
        ),
        maxHeight: 200,
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        customHeights: items.map((_) => 48.0).toList(),
      ),
    );
  }
}
