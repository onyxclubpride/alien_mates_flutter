import 'dart:developer';

logger(str, {String? hint}) {
  log(hint ?? 'LOGGER');
  log(str.toString().toUpperCase());
  log(hint ?? 'LOGGER');
}
