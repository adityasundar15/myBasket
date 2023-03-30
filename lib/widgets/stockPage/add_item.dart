import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list/models/item.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final titleController = TextEditingController();
  DateTime? _selectedExpiryDate;
  DateTime? _selectedPurchaseDate;

  void _presentDatePickerExpiry() {
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
          _selectedExpiryDate = value;
        });
      }
    });
  }

  void _presentDatePickerPurchase() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 60)),
            lastDate: DateTime.now().add(const Duration(days: 2)))
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _selectedPurchaseDate = value;
        });
      }
    });
  }

  void _submitData() {
    final enteredTitle = titleController.text;
    // final enteredAmount = double.parse(amountController.text);
    // print('$enteredAmount $enteredTitle');

    if (enteredTitle.isEmpty) {
      return;
    }
    final myItem = Item(
        title: enteredTitle,
        purchaseDate: _selectedPurchaseDate!,
        expiryDate: _selectedExpiryDate!);
    Navigator.of(context).pop(myItem);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: const Text(
                    "Add New Item to Current Stock",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Product Name',
                  ),
                  controller: titleController,
                  onSubmitted: (value) => _submitData(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(_selectedPurchaseDate == null
                              ? "Choose purchase date:"
                              : 'Date of Purchase: ${DateFormat.yMd().format(_selectedPurchaseDate!).toString()}'),
                        ),
                        TextButton(
                            onPressed: _presentDatePickerPurchase,
                            child: Text(
                                _selectedPurchaseDate == null
                                    ? "Choose date"
                                    : "Change date",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                )))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(_selectedExpiryDate == null
                              ? "Choose expiry date:"
                              : 'Date of Expiry: ${DateFormat.yMd().format(_selectedExpiryDate!).toString()}'),
                        ),
                        TextButton(
                            onPressed: _presentDatePickerExpiry,
                            child: Text(_selectedExpiryDate == null
                                ? "Choose date"
                                : "Change date"))
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: _submitData, child: const Text("Add Item"))
              ])),
    );
  }
}
