import 'package:flutter/material.dart';
import 'package:flutter_application_1/Miapp_crypto.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_application_1/repositories/crypto_coins/crypto_coins_repositoriy.dart';


void main() {
  // Регистрируем Dio
  GetIt.I.registerSingleton<Dio>(Dio());
  
  // Регистрируем репозиторий
  GetIt.I.registerSingleton<CryptoCoinsRepository>(
    CryptoCoinsRepository(dio: GetIt.I<Dio>())
  );
  
  runApp(const Miapp());
}