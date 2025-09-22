import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cripto_list/cripto_llist.dart';
import 'package:flutter_application_1/features/single_cripto/single_cripto_screen.dart';

final Map<String, WidgetBuilder> routes = {
        '/coins-list': (context) => const CryptoCoinScreen(),
        '/cryptocoin': (context) => const Cryptocoin(),
      };

