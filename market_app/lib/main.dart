import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/product_card.dart';
import 'models/product.dart';
import 'providers/cart_provider.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Market App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const ProductListScreen(),
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      Product(
        id: '1',
        imageUrl: 'https://via.placeholder.com/300x200?text=Laptop',
        name: 'Premium Laptop',
        price: 1299.99,
        description: 'High-performance laptop with 16GB RAM and SSD storage',
      ),
      Product(
        id: '2',
        imageUrl: 'https://via.placeholder.com/300x200?text=Headphones',
        name: 'Wireless Headphones',
        price: 199.99,
        description: 'Noise-cancelling headphones with 30-hour battery life',
      ),
      Product(
        id: '3',
        imageUrl: 'https://via.placeholder.com/300x200?text=Smartwatch',
        name: 'Smart Watch',
        price: 299.99,
        description: 'Feature-rich smartwatch with fitness tracking and notifications',
      ),
      Product(
        id: '4',
        imageUrl: 'https://via.placeholder.com/300x200?text=Camera',
        name: 'Digital Camera',
        price: 899.99,
        description: '4K digital camera with advanced autofocus and stabilization',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market App'),
        centerTitle: true,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartScreen()),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                  if (cartProvider.totalQuantity > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${cartProvider.totalQuantity}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}
