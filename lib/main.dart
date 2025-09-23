import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Miapp_crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/repositories/crypto_coins/crypto_coins_repositoriy.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_application_1/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton<Talker>(talker);
  GetIt.I.registerSingleton<Dio>(Dio());
  GetIt.I<Talker>().debug('Talker and Dio are initialized');
  // Регистрируем репозиторий КАК AbstractCoinsRepository
  GetIt.I.registerSingleton<AbstractCoinsRepository>(
    CryptoCoinsRepository(dio: GetIt.I<Dio>())
  );

  FlutterError.onError = 
  (details) =>
    GetIt.I<Talker>().handle(details.exception, details.stack);
  ;
  
  runZonedGuarded(
    () =>   runApp(const Miapp()), 
    (error, stackTrace) => GetIt.I<Talker>().handle(error, stackTrace))
  ;
}