import 'package:flutter/material.dart';
import 'package:flutter_application_1/repositories/crypto_coins/models/crypto_coin.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: _buildCoinImage(),
      title: Text(
        coin.name,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        '${coin.priceInUSD.toStringAsFixed(2)} \$', // Форматируем цену
        style: theme.textTheme.labelSmall,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/coin',
          arguments: coin,
        );
      },
    );
  }

  Widget _buildCoinImage() {
    if (coin.imageUrl != null) {
      return Image.network(coin.imageUrl!); // ! - утверждаем что не null
    } else {
      // Запасная иконка если нет изображения
      return const Icon(Icons.currency_bitcoin);
    }
  }
}