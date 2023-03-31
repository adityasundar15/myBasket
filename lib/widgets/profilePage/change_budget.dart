import 'package:flutter/material.dart';
import '../../chart_data.dart';

class ChangeBudgetDialog extends StatefulWidget {
  // final Function changeBudget;

  // const ChangeBudgetDialog({required this.changeBudget, super.key});
  const ChangeBudgetDialog({super.key});
  @override
  State<ChangeBudgetDialog> createState() => _ChangeBudgetDialogState();
}

class _ChangeBudgetDialogState extends State<ChangeBudgetDialog> {
  final totalBudgetController = TextEditingController();

  void _submitData() {
    final double enteredBudget = double.parse(totalBudgetController.text);
    // print(enteredBudget);
    if (enteredBudget <= 0) {
      return;
    }
    Navigator.of(context).pop(enteredBudget);
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
              'Current budget: $totalBudget',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter new budget',
              ),
              controller: totalBudgetController,
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true, signed: true),
              onSubmitted: (value) => _submitData(),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: _submitData, child: const Text('Change budget'))
          ],
        ),
      ),
    );
  }
}
