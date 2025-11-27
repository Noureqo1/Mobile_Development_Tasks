import 'package:flutter/material.dart';
import 'widgets/product_card.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Market App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'imageUrl': 'https://via.placeholder.com/300x200?text=Laptop',
        'name': 'Premium Laptop',
        'price': 1299.99,
        'description': 'High-performance laptop with 16GB RAM and SSD storage',
      },
      {
        'imageUrl': 'https://via.placeholder.com/300x200?text=Headphones',
        'name': 'Wireless Headphones',
        'price': 199.99,
        'description': 'Noise-cancelling headphones with 30-hour battery life',
      },
      {
        'imageUrl': 'https://via.placeholder.com/300x200?text=Smartwatch',
        'name': 'Smart Watch',
        'price': 299.99,
        'description': 'Feature-rich smartwatch with fitness tracking and notifications',
      },
      {
        'imageUrl': 'https://via.placeholder.com/300x200?text=Camera',
        'name': 'Digital Camera',
        'price': 899.99,
        'description': '4K digital camera with advanced autofocus and stabilization',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market App'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            imageUrl: product['imageUrl'] as String,
            productName: product['name'] as String,
            price: product['price'] as double,
            description: product['description'] as String,
          );
        },
      ),
    );
  }
}
