import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:survey/components/kTextInput.dart';
import 'package:survey/utils/appTheme.dart';

class DatePickerInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final DateTime firstDate, lastDate, initialDate;
  final DateFormat dateFormat;

  const DatePickerInputField(
      {Key? key,
        required this.label,
        required this.controller,
        required this.firstDate,
        required this.lastDate,
        required this.dateFormat,
        required this.initialDate})
      : super(key: key);

  @override
  _DatePickerInputFieldState createState() => _DatePickerInputFieldState();
}

class _DatePickerInputFieldState extends State<DatePickerInputField> {

  // final dateFormat = new DateFormat('dd/MM/yyyy');
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      builder: (context, child) {
        return Theme(
          data: AppThemeData.lightTheme,
          child: child!,
        );
      },
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        widget.controller.text = widget.dateFormat.format(pickedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return KTextInput(
      controller: widget.controller,
      textInputAction: TextInputAction.next,
      onTap: _presentDatePicker, label: 'DOB',
    );
  }
}
