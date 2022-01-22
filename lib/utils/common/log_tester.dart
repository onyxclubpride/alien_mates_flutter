import 'dart:developer';

logger(str, {String? hint}) {
  log(hint ?? 'LOGGER');
  log(str.toString());
  log(hint ?? 'LOGGER');
}
