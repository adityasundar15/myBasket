import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';

class AddTransactionPopUp extends StatefulWidget {
  const AddTransactionPopUp({super.key});

  @override
  State<AddTransactionPopUp> createState() => _AddTransactionPopUpState();
}

class _AddTransactionPopUpState extends State<AddTransactionPopUp> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
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
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    print('$enteredAmount $enteredTitle');

    if (enteredAmount <= 0) {
      return;
    }
    Navigator.of(context).pop({
      'title': enteredTitle,
      'amount': enteredAmount,
      'date': _selectedDate
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: const Text(
                    "Add transaction",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Title (Optional)',
                  ),
                  controller: titleController,
                  onSubmitted: (value) => _submitData(),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (value) => _submitData(),
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
                    onPressed: _submitData,
                    child: const Text("Add Transaction"))
              ])),
    );
    ;
  }
}
