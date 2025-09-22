import 'package:flutter/material.dart';
import 'package:flutter_application_1/Miapp_crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/repositories/crypto_coins/crypto_coins_repositoriy.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_application_1/repositories/crypto_coins/abstract_coins_repository.dart';

void main() {
  // Регистрируем Dio
  GetIt.I.registerSingleton<Dio>(Dio());
  
  // Регистрируем репозиторий КАК AbstractCoinsRepository
  GetIt.I.registerSingleton<AbstractCoinsRepository>(
    CryptoCoinsRepository(dio: GetIt.I<Dio>())
  );
  
  runApp(const Miapp());
}