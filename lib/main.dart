import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Miapp_crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/repositories/crypto_coins/crypto_coins_repositoriy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_application_1/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  // 1. Инициализируем Talker
  final talker = TalkerFlutter.init();
  
  // 2. Создаем Dio и добавляем интерцептор ПЕРЕД регистрацией
  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(printResponseData: false // Включи для детальных логов
      ),
    ),
  );
  Bloc.observer = TalkerBlocObserver(
    talker: talker, 
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
  ));



  // 3. Регистрируем зависимости в GetIt
  GetIt.I.registerSingleton<Talker>(talker);
  GetIt.I.registerSingleton<Dio>(dio); // Регистрируем тот же экземпляр с интерцептором!
  
  GetIt.I<Talker>().debug('Dependencies initialized with Dio logger');
  
  // 4. Регистрируем репозиторий
  GetIt.I.registerSingleton<AbstractCoinsRepository>(
    CryptoCoinsRepository(dio: GetIt.I<Dio>()) // Используем залогированный Dio
  );

  // 5. Настройка обработки ошибок
  FlutterError.onError = (details) {
    GetIt.I<Talker>().handle(details.exception, details.stack);
  };
  
  runZonedGuarded(
    () => runApp(const Miapp()),
    (error, stackTrace) => GetIt.I<Talker>().handle(error, stackTrace),
  );
}