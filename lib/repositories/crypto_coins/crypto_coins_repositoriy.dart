// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter_application_1/repositories/crypto_coins/models/crypto_coin_details.dart';
import 'abstract_coins_repository.dart';
import 'models/crypto_coin.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AID,BTO,SOL,CAG,DOV&tsyms=USD'
    );
    
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    
    final cryptoCoinList = dataRaw.entries.map((e) {
      final usdData = (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      
      // Преобразуем данные API в формат для модели
      final details = CryptoCoinDetail(
        toSymbol: usdData['TOSYMBOL']?.toString() ?? 'USD',
        lastUpdate: DateTime.fromMillisecondsSinceEpoch(
          (usdData['LASTUPDATE'] as int? ?? 0) * 1000),
        high24Hour: (usdData['HIGH24HOUR'] as num?)?.toDouble() ?? 0.0,
        low24Hour: (usdData['LOW24HOUR'] as num?)?.toDouble() ?? 0.0,
        priceInUSD: (usdData['PRICE'] as num?)?.toDouble() ?? 0.0,
        imageUrl: usdData['IMAGEURL']?.toString(),
      );
      
      return CryptoCoin(
        details: details,
        name: e.key,
      );
    }).toList();
    
    return cryptoCoinList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD'
    );

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    
    final details = CryptoCoinDetail(
      toSymbol: usdData['TOSYMBOL']?.toString() ?? 'USD',
      lastUpdate: DateTime.fromMillisecondsSinceEpoch(
        (usdData['LASTUPDATE'] as int? ?? 0) * 1000),
      high24Hour: (usdData['HIGH24HOUR'] as num?)?.toDouble() ?? 0.0,
      low24Hour: (usdData['LOW24HOUR'] as num?)?.toDouble() ?? 0.0,
      priceInUSD: (usdData['PRICE'] as num?)?.toDouble() ?? 0.0,
      imageUrl: usdData['IMAGEURL']?.toString(),
    );

    return CryptoCoin(
      name: currencyCode,
      details: details,
    );
  }
}