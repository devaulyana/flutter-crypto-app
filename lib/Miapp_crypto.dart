import 'package:flutter/material.dart';
import 'package:flutter_application_1/router/router.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class Miapp extends StatelessWidget {
  const Miapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darktheme,
      routes: routes,
      navigatorObservers: [
        TalkerRouteObserver(GetIt.I<Talker>()),
      ],
    );
  } 
}



