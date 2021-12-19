import 'package:intl/intl.dart';

const _currency2Locale = {'KRW': 'ko', 'USD': 'en'};

class CurrencyFormatter {
  static NumberFormat simpleCurrency =
      NumberFormat.simpleCurrency(locale: "ko_KR");
  static NumberFormat noSymbolCurrency =
      NumberFormat.currency(locale: "ko_KR", symbol: '');
  static NumberFormat get(int minimumFractionDigits,
      [String locale = "ko_KR"]) {
    simpleCurrency = NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: minimumFractionDigits);
    return simpleCurrency;
  }
}

class DecimalFormatter {
  static NumberFormat simpleDecimal = NumberFormat.decimalPattern("ko_KR");

  static void set(String currency) {
    if (_currency2Locale.containsKey(currency)) {
      simpleDecimal = NumberFormat.decimalPattern(_currency2Locale[currency]);
    }
  }
}
