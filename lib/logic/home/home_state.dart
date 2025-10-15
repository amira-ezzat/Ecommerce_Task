import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Product> products;
  final List<String> categories;

  const HomeLoaded({required this.products, required this.categories});

  @override
  List<Object> get props => [products, categories];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}