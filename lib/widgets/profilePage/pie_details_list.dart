import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../chart_data.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';

class PieDetailsList extends StatelessWidget {
  const PieDetailsList({super.key});

  static const routeName = '/pie-details-list';

  Widget displayDetailsForMonth(List<Transaction> trans, int month) {
    // List<Transaction>? mytrans = getTransactionForMonth(trans, month);
    List<Transaction> transForMonth = [];
    trans.forEach((element) {
      if (element.dateOfTransaction.month == month) {
        transForMonth.add(element);
      }
    });

    return transForMonth.isEmpty
        ? const Text('No transactions to display.')
        : ListView.builder(
            itemCount: transForMonth.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onLongPress: null,
                  leading: CircleAvatar(
                    radius: 40,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FittedBox(
                            child: Text('\$${transForMonth[index].amount}'))),
                  ),
                  title: Text(
                    DateFormat('d MMMM y')
                        .format(transForMonth[index].dateOfTransaction),
                    style: const TextStyle(fontSize: 18),
                  ),
                  // trailing: IconButton(onPressed: null, icon: Icon(Icons.edit)),
                ),
              );
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
        title: const Text(
          'Details',
          style: TextStyle(fontSize: 28),
        ),
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: null,
                  child: Text(
                    "<",
                    style: TextStyle(
                        fontSize: 24, color: Theme.of(context).primaryColor),
                  )),
              Text(
                DateFormat.MMMM().format(DateTime.now()).toString(),
                style: TextStyle(
                    fontSize: 24, color: Theme.of(context).primaryColor),
              ),
              TextButton(
                  onPressed: null,
                  child: Text(
                    ">",
                    style: TextStyle(
                        fontSize: 24, color: Theme.of(context).primaryColor),
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 600,
            child:
                displayDetailsForMonth(allTransactions, DateTime.now().month),
          )
        ],
      ),
    );
  }
}
