import '../models/item.dart';
import 'shopping_item.dart';
import '../myUtils.dart';

void convertShoppingItemToItem(ShoppingItem shoppingItem) {
  final expiryDate = DateTime.parse(shoppingItem.fridgeExpiryDate!);
  final purchaseDate = shoppingItem.timeBought != null
      ? DateTime.parse(shoppingItem.timeBought!)
      : DateTime.now();
  final convertedItem = Item(
      title: shoppingItem.name,
      purchaseDate: purchaseDate,
      expiryDate: expiryDate);
  if (allItems.containsKey(convertedItem.expiryDate)) {
    allItems[convertedItem.expiryDate]!.add(convertedItem);
    kItems[convertedItem.expiryDate]!.add(convertedItem);
  } else {
    allItems[convertedItem.expiryDate] = [convertedItem];
    kItems[convertedItem.expiryDate] = [convertedItem];
  }
}
