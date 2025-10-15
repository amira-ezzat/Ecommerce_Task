import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {}

class CartProductAdded extends CartEvent {
  final Product product;

  const CartProductAdded(this.product);

  @override
  List<Object> get props => [product];
}

class CartProductRemoved extends CartEvent {
  final int productId;

  const CartProductRemoved(this.productId);

  @override
  List<Object> get props => [productId];
}

class CartQuantityIncreased extends CartEvent {
  final int productId;

  const CartQuantityIncreased(this.productId);

  @override
  List<Object> get props => [productId];
}

class CartQuantityDecreased extends CartEvent {
  final int productId;

  const CartQuantityDecreased(this.productId);

  @override
  List<Object> get props => [productId];
}