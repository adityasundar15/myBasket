class Transaction {
  final DateTime dateOfTransaction;
  final double amount;
  final String? title;

  Transaction(
      {required this.dateOfTransaction, required this.amount, this.title});
}
