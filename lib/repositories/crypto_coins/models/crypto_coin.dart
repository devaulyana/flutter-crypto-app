// models/crypto_coin.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repositories/crypto_coins/crypto_coins.dart';

class CryptoCoin extends Equatable {
  final String name;
  final CryptoCoinDetail details;

  const CryptoCoin({
    required this.name,
    required this.details,
  });

  @override
  List<Object?> get props => [name, details];

  // Геттер вместо метода
  dynamic get fullImageUrl => null;
}