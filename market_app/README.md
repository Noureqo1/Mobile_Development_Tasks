# market_app

The Market App now includes a complete shopping cart system with all requested features.

## Features Implemented

### 1. **Add/Remove Items** ✅
- **Add to Cart**: Click the "Add" button on any product card to add items to the cart
- **Remove from Cart**: Click the delete icon in the cart to remove items
- **Quantity Management**: Use +/- buttons to increase or decrease item quantities
- **Smart Add**: Adding the same product multiple times increases its quantity

### 2. **Calculate Total Price** ✅
- **Subtotal**: Displays the sum of all product prices × quantities
- **Discount Amount**: Shows the discount value when applicable
- **Total Price**: Calculates final price after discount
- **Real-time Updates**: All calculations update instantly as items are added/removed

### 3. **Clear Cart** ✅
- **Clear All Items**: "Clear Cart" button removes all items at once
- **Confirmation Dialog**: Shows a confirmation before clearing to prevent accidents
- **Reset Discount**: Discount is also reset when cart is cleared

### 4. **Apply Discounts** ✅
- **Automatic Discount**: 10% discount automatically applied when subtotal ≥ $500
- **Discount Display**: Shows discount percentage and amount in the cart summary
- **Threshold-based**: Discount is removed if subtotal falls below $500

## File Structure

```
lib/
├── main.dart                 # Main app with ProductListScreen
├── models/
│   └── product.dart         # Product and CartItem models
├── providers/
│   └── cart_provider.dart   # CartProvider for state management
├── screens/
│   └── cart_screen.dart     # Shopping cart screen
└── widgets/
    └── product_card.dart    # Product card widget
```

## Key Components

### ProductCard Widget
- Displays product image, name, description, and price
- "Add" button to add items to cart
- Shows success snackbar when item is added

### CartScreen
- Lists all cart items with images and details
- Quantity controls (+/- buttons)
- Remove button for each item
- Price summary with subtotal, discount, and total
- Clear Cart button with confirmation
- Checkout button

### CartProvider (State Management)
- Manages cart items list
- Handles add/remove/update operations
- Calculates subtotal, discount, and total price
- Applies discount based on threshold
- Tracks total quantity of items

## How to Use

1. **Browse Products**: View products in the grid on the home screen
2. **Add to Cart**: Click "Add" button on any product
3. **View Cart**: Click the shopping cart icon in the app bar
4. **Manage Items**: Adjust quantities or remove items in the cart
5. **Check Discount**: If subtotal ≥ $500, a 10% discount is automatically applied
6. **Clear Cart**: Use the "Clear Cart" button to remove all items
7. **Checkout**: Click "Checkout" to proceed (placeholder functionality)

## Dependencies
- `provider: ^6.0.0` - For state management

## Notes
- Placeholder images are used from via.placeholder.com
- Discount threshold is set to $500 with 10% discount
- All prices are displayed in USD format
