import 'package:flutter/material.dart';

class CryptoCoinDetailsScreen extends StatelessWidget {
  const CryptoCoinDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Details'),
      ),
      body: const Center(
        child: Text('Crypto Details Page'),
      ),
    );
  }
}

