import 'package:intl/intl.dart';

String formatPrice(num value) {
  final formatter = NumberFormat('#,##0', 'tr_TR');
  return '${formatter.format(value)} ₺';
}

String formatDate(DateTime date) {
  return DateFormat('dd.MM.yyyy', 'tr_TR').format(date);
}

String formatTime(DateTime date) {
  return DateFormat('HH:mm', 'tr_TR').format(date);
}
