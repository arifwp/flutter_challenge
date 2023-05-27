import 'package:flutter/material.dart';
import 'package:flutter_challenge/components/alert.dart';
import 'package:intl/intl.dart';

class AppDatePicker extends StatefulWidget {
  const AppDatePicker(this.hint, this.controller, {super.key});

  final String hint;
  final TextEditingController controller;

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  showDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      print(selectedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      print(formattedDate);
      setState(() {
        widget.controller.text = formattedDate;
      });
    } else {
      alertDialog(context, 'Not selecting any date');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        icon: Icon(Icons.calendar_month),
        labelText: 'Enter date',
      ),
      readOnly: true,
      onTap: showDate,
    );
  }
}
