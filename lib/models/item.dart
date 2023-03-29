enum Category { fridge, freezer, pantry, snacks, canned, unknown }

enum Unit {
  litres,
  mililitres,
  grams,
  kilograms,
  dozen,
  oz,
}

class Item {
  final String title;
  final DateTime purchaseDate;
  DateTime expiryDate;
  final double? amount;
  final Unit? unit;
  final Category? category;

  Item(
      {required this.title,
      required this.purchaseDate,
      required this.expiryDate,
      this.amount,
      this.unit,
      this.category});
}
