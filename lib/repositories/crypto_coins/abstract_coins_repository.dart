import 'package:flutter_application_1/repositories/crypto_coins/models/crypto_coin.dart';

abstract class AbstractCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList();
}