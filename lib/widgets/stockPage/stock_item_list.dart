import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import '../../models/returnItemData.dart';
import '../../myUtils.dart';
import 'package:intl/intl.dart';

import '../../models/item.dart';
import './stock_each_item.dart';
import './edit_expiry.dart';

class StockItemList extends StatefulWidget {
  final List<Item> itemList;

  const StockItemList({required this.itemList, super.key});

  @override
  State<StockItemList> createState() => _StockItemListState();
}

class _StockItemListState extends State<StockItemList> {
  void showEditExpiry(BuildContext context, Item item) {
    showModalBottomSheet(
        context: context,
        builder: (builderContext) {
          return GestureDetector(
              onTap: null,
              behavior: HitTestBehavior.opaque,
              // display what should be inside the modal sheet.
              child: EditExpiryDialog(
                  editingItem: item, currentExpiry: item.expiryDate));
        }).then((data) {
      returnItemData myval = data;
      // first remove the value from kItems
      kItems.forEach((key, value) {
        value.removeWhere((element) =>
            element.title == myval.item.title && key == myval.item.expiryDate);
      });

      // update the item expiry date
      item.expiryDate = myval.newExpiryDate;

      // update the kItems to include the correct date.
      // first check if the new expiry date exists.
      if (!kItems.keys.contains(item.expiryDate)) {
        kItems[item.expiryDate] = [];
      }
      setState(() {
        kItems[item.expiryDate]?.add(item);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemList.length,
      itemBuilder: (context, index) {
        return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: StockEachItem(
              itemList: widget.itemList,
              index: index,
              showSheet: () {
                showEditExpiry(context, widget.itemList[index]);
              },
            ));
      },
    );
  }
}
