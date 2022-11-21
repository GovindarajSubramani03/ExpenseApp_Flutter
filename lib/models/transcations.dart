class Transactions {
  final String id;
  final String title;
  final double amount;
  DateTime date;

  Transactions(
      {required this.id,
      required this.amount,
      required this.title,
      required this.date});
}
