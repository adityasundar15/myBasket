import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/item.dart';
import './edit_expiry.dart';

class StockEachItem extends StatelessWidget {
  final List<Item> itemList;
  final int index;
  final VoidCallback showSheet;
  const StockEachItem(
      {required this.itemList,
      required this.index,
      required this.showSheet,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: null,
      title: Text(itemList[index].title),
      subtitle: Text(
          'Expires on: ${DateFormat.yMd().format(itemList[index].expiryDate)}'),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: showSheet,
      ),
    );
  }
}
