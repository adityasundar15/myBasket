import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

import 'models/item.dart';

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final Map<DateTime, List<Item>> allItems = {
  DateTime(2023, 3, 30): [
    Item(
        title: 'Eggs',
        purchaseDate: DateTime(2023, 3, 23),
        expiryDate: DateTime(2023, 3, 30)),
    Item(
        title: 'Milk',
        purchaseDate: DateTime(2023, 3, 23),
        expiryDate: DateTime(2023, 3, 30))
  ],
  DateTime(2023, 3, 31): [
    Item(
        title: 'Bread',
        purchaseDate: DateTime(2023, 3, 23),
        expiryDate: DateTime(2023, 3, 31)),
    Item(
        title: 'Snacks',
        purchaseDate: DateTime(2023, 3, 23),
        expiryDate: DateTime(2023, 3, 31))
  ],
  DateTime(2023, 3, 28): [
    Item(
        title: 'Rice',
        purchaseDate: DateTime(2023, 3, 23),
        expiryDate: DateTime(2023, 3, 28))
  ],
  DateTime(2023, 4, 15): [
    Item(
        title: 'Water',
        purchaseDate: DateTime(2023, 3, 27),
        expiryDate: DateTime(2023, 4, 15)),
    Item(
        title: 'Cake',
        purchaseDate: DateTime(2023, 3, 28),
        expiryDate: DateTime(2023, 4, 15))
  ]
};

final kItems = LinkedHashMap<DateTime, List<Item>>(
    equals: isSameDay, hashCode: getHashCode)
  ..addAll(allItems);
