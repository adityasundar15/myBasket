import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/profilePage/add_trans_popup.dart';

import '../widgets/profilePage/pie_card.dart';
import '../widgets/profilePage/bar_card.dart';
import '../chart_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void showAddTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builderContext) {
          return GestureDetector(
              onTap: null,
              behavior: HitTestBehavior.opaque,
              // display what should be inside the modal sheet.
              child: const AddTransactionPopUp());
        }).then((data) {
      if (data['title']!.isEmpty) {
        setState(() {
          allTransactions.add(Transaction(
              dateOfTransaction: data['date'], amount: data['amount']));
          givePieData(totalBudget);
          barData = getBarData();
        });
      } else {
        setState(() {
          allTransactions.add(Transaction(
              title: data['title'],
              dateOfTransaction: data['date'],
              amount: data['amount']));
          givePieData(totalBudget);
          barData = getBarData();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
                width: double.infinity,
                child: ProfilePieCard(
                  getPieData: givePieData,
                )),
            ProfileBarCard(data: barData),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTransaction(context);
          },
          child: const Icon(Icons.add)),
    );
  }
}
