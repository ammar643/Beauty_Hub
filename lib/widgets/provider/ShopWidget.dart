import 'package:flutter/material.dart';

class ShopWidget extends StatelessWidget {
  const ShopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'المتجر قيد التطوير',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}