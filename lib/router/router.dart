
import 'package:flutter_application_1/features/cripto_list/view/cripto_list_screen.dart';
import 'package:flutter_application_1/features/single_cripto/view/single_cripto.dart';

final routes = {
  '/': (context) => const CryptoListScreen(),
  '/coin': (context) => const CryptoCoinScreen(),
};