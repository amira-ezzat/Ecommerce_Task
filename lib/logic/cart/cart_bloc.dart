import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/cart_item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStarted>(_onCartStarted);
    on<CartProductAdded>(_onCartProductAdded);
    on<CartProductRemoved>(_onCartProductRemoved);
    on<CartQuantityIncreased>(_onCartQuantityIncreased);
    on<CartQuantityDecreased>(_onCartQuantityDecreased);
  }

  // In-memory list to store cart items
  final List<CartItem> _cartItems = [];

  void _onCartStarted(CartStarted event, Emitter<CartState> emit) {
    emit(_calculateTotals(_cartItems));
  }

  void _onCartProductAdded(CartProductAdded event, Emitter<CartState> emit) {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == event.product.id);
    if (existingIndex != -1) {
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + 1,
      );
    } else {
      _cartItems.add(CartItem(product: event.product, quantity: 1));
    }
    emit(_calculateTotals([..._cartItems]));
  }

  void _onCartProductRemoved(CartProductRemoved event, Emitter<CartState> emit) {
    _cartItems.removeWhere((item) => item.product.id == event.productId);
    emit(_calculateTotals([..._cartItems]));
  }

  void _onCartQuantityIncreased(CartQuantityIncreased event, Emitter<CartState> emit) {
    final index = _cartItems.indexWhere((item) => item.product.id == event.productId);
    if (index != -1) {
      final item = _cartItems[index];
      _cartItems[index] = item.copyWith(quantity: item.quantity + 1);
    }
    emit(_calculateTotals([..._cartItems]));
  }

  void _onCartQuantityDecreased(CartQuantityDecreased event, Emitter<CartState> emit) {
    final index = _cartItems.indexWhere((item) => item.product.id == event.productId);
    if (index != -1) {
      final item = _cartItems[index];
      if (item.quantity > 1) {
        _cartItems[index] = item.copyWith(quantity: item.quantity - 1);
      } else {
        _cartItems.removeAt(index);
      }
    }
    emit(_calculateTotals([..._cartItems]));
  }

  CartLoaded _calculateTotals(List<CartItem> items) {
    final subtotal = items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
    // Simple fixed shipping cost for demonstration
    const shipping = 5.00;
    final total = subtotal + shipping;
    return CartLoaded(
      items: items,
      subtotal: subtotal,
      shipping: items.isEmpty ? 0 : shipping,
      total: items.isEmpty ? 0 : total,
    );
  }
}