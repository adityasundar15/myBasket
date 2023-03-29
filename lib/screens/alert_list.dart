import 'dart:collection';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/item.dart';
import '../myUtils.dart';

class AlertList extends StatelessWidget {
  // get a list of all events and then filter based on date.
  // final LinkedHashMap<DateTime, List<Item>> kItems;

  const AlertList({super.key});

  static const routeName = '/alert-list';

  // void filterExpiryItems(Map<Date)

  @override
  Widget build(BuildContext context) {
    int daysBetween(DateTime from, DateTime to) {
      // from -> current date
      // to -> future date to check
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }

    List<Item> sortItems(List<Item> litems) {
      // sort the items in ascending order
      litems.sort(
          (a, b) => a.expiryDate.toString().compareTo(b.expiryDate.toString()));
      return litems;
    }

    List<Item> getItemsToDisplay() {
      List<Item> items = [];
      for (var k in kItems.keys) {
        // print('$k, ${daysBetween(DateTime.now(), k)}');
        // add items that are going to expire 3-5 days from now.
        if (daysBetween(DateTime.now(), k) >= 0 &&
            daysBetween(DateTime.now(), k) <= 5) {
          for (int i = 0; i < kItems[k]!.length; i++) {
            items.add(kItems[k]![i]);
            // print(items);
          }
        }
      }
      return sortItems(items);
    }

    Widget displayListForDate() {
      // Map<DateTime, List<Item>>? itemsToDisp = getItemsToDisplay();
      List<Item>? itemsToDisp = getItemsToDisplay();
      if (itemsToDisp.isNotEmpty) {
        return ListView.builder(
            itemCount: itemsToDisp.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  // display only if its the first item for that day
                  index > 1 &&
                          itemsToDisp[index - 1].expiryDate ==
                              itemsToDisp[index].expiryDate
                      ? const SizedBox()
                      : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          color: Colors.purple[100],
                          child: Text(
                            DateFormat.yMd()
                                .format(itemsToDisp[index].expiryDate),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                  ListTile(
                    onLongPress: null,
                    title: Text(itemsToDisp[index].title),
                    subtitle: Text(
                        'Expires on: ${DateFormat.yMd().format(itemsToDisp[index].expiryDate)}'),
                  ),
                ],
              );
            });
      }
      return Text('No items to display.');
    }

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
          'Alerts',
          style: TextStyle(fontSize: 28),
        ),
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        width: double.infinity,
        height: 700,
        child: displayListForDate(),
      ),
    );
  }
}
