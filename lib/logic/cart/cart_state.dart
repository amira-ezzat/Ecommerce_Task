import 'package:equatable/equatable.dart';
import '../../data/models/cart_item_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final double subtotal;
  final double shipping;
  final double total;

  const CartLoaded({
    this.items = const [],
    this.subtotal = 0.0,
    this.shipping = 0.0,
    this.total = 0.0,
  });

  @override
  List<Object> get props => [items, subtotal, shipping, total];
}