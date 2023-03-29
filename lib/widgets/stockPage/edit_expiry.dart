import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/item.dart';
import '../../models/returnItemData.dart';

class EditExpiryDialog extends StatefulWidget {
  final DateTime currentExpiry;
  final Item editingItem;
  const EditExpiryDialog(
      {required this.editingItem, required this.currentExpiry, super.key});

  @override
  State<EditExpiryDialog> createState() => _EditExpiryDialogState();
}

class _EditExpiryDialogState extends State<EditExpiryDialog> {
  @override
  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: widget.editingItem.expiryDate,
            firstDate: DateTime.now().subtract(const Duration(days: 1)),
            lastDate: DateTime.now().add(const Duration(days: 30)))
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  void _submitData() {
    print(_selectedDate);
    Navigator.of(context).pop(returnItemData(
        item: widget.editingItem, newExpiryDate: _selectedDate!));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current expiry date: ${DateFormat.yMd().format(widget.currentExpiry).toString()}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? "No date chosen."
                        : 'Date Picked: ${DateFormat.yMd().format(_selectedDate!).toString()}'),
                  ),
                  TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(_selectedDate == null
                          ? "Choose date"
                          : "Change date"))
                ],
              ),
            ),
            ElevatedButton(
                onPressed: _submitData, child: const Text('Change expiry date'))
          ],
        ),
      ),
    );
  }
}
