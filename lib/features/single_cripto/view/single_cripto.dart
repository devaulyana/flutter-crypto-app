import 'package:flutter/material.dart';

class Cryptocoin extends StatelessWidget {
  const Cryptocoin({super.key});

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

