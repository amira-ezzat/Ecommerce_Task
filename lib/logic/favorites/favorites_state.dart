import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';

class FavoritesState extends Equatable {
  final List<Product> favoriteProducts;

  const FavoritesState({this.favoriteProducts = const []});

  @override
  List<Object> get props => [favoriteProducts];
}