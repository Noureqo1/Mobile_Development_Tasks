import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  double _discountPercentage = 0;

  List<CartItem> get cartItems => _cartItems;
  double get discountPercentage => _discountPercentage;

  // Add item to cart or increase quantity if already exists
  void addItem(Product product) {
    final existingItem = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }
    notifyListeners();
  }

  // Remove item from cart
  void removeItem(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  // Update item quantity
  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }

    final item = _cartItems.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product(
        id: '',
        imageUrl: '',
        name: '',
        price: 0,
        description: '',
      )),
    );

    if (item.product.id.isNotEmpty) {
      item.quantity = quantity;
      notifyListeners();
    }
  }

  // Calculate subtotal
  double get subtotal {
    return _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  // Calculate discount amount
  double get discountAmount {
    return subtotal * (_discountPercentage / 100);
  }

  // Calculate total price after discount
  double get totalPrice {
    return subtotal - discountAmount;
  }

  // Apply discount based on subtotal threshold
  void applyDiscount(double threshold, double discountPercent) {
    if (subtotal >= threshold) {
      _discountPercentage = discountPercent;
    } else {
      _discountPercentage = 0;
    }
    notifyListeners();
  }

  // Clear cart
  void clearCart() {
    _cartItems.clear();
    _discountPercentage = 0;
    notifyListeners();
  }

  // Get cart item count
  int get itemCount => _cartItems.length;

  // Get total quantity of all items
  int get totalQuantity {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }
}
