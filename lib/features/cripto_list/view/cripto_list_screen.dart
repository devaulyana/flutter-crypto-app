import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cripto_list/bloc/crypto_list_bloc.dart';
import 'package:flutter_application_1/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter_application_1/features/cripto_list/widgets/widgets.dart';


class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  late Future<List<CryptoCoin>> _coinsFuture;
  final _repo = CryptoCoinsRepository(dio: Dio()); // создаём один раз

  @override
  void initState() {
    super.initState();
    _loadCoins();
  }

  void _loadCoins() {
    _coinsFuture = _repo.getCoinsList();
  }

  void _refreshCoins() {
    setState(() {
      _loadCoins(); // просто обновляем Future
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Crypto Coins'),
    ),
    body: FutureBuilder<List<CryptoCoin>>(
      future: _coinsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(child: Text("Error: ${snapshot.error}")),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(child: Text("No data")),
          );
        }

        final coins = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.all(16.0), // Паддинг вокруг всего списка
          itemCount: coins.length,
          separatorBuilder: (_, __) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0), // Отступ вокруг разделителя
            child: Divider(
              color: Color.fromARGB(255, 192, 91, 91), // Более мягкий цвет
              height: 1,
              thickness: 1,
            ),
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Паддинг для каждого элемента
            child: CryptoCoinTile(coin: coins[index]),
          ),
        );
      },
    ),
    floatingActionButton: Padding(
      padding: const EdgeInsets.only(bottom: 16.0, right: 16.0), // Отступ для FAB
      child: FloatingActionButton(
        onPressed: _refreshCoins,
        child: const Icon(Icons.refresh),
      ),
    ),
  );
}
}