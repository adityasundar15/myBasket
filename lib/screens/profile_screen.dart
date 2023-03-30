import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/transaction.dart';
import '../widgets/profilePage/add_trans_popup.dart';

import '../widgets/profilePage/pie_card.dart';
import '../widgets/profilePage/bar_card.dart';
import '../chart_data.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

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
              child: AddTransactionPopUp());
        }).then((data) {
      if (data['title']!.isEmpty) {
        setState(() {
          allTransactions.add(Transaction(
              dateOfTransaction: data['date'], amount: data['amount']));
        });
      } else {
        setState(() {
          allTransactions.add(Transaction(
              dateOfTransaction: data['date'], amount: data['amount']));
        });
      }
      ;
    });
  }

  // void addTransaction(
  //     {String? title, required DateTime date, required double amount}) {
  //   if (title!.isEmpty) {
  //     allTransactions.add(Transaction(dateOfTransaction: date, amount: amount));
  //   } else {
  //     allTransactions.add(
  //         Transaction(title: title, dateOfTransaction: date, amount: amount));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
