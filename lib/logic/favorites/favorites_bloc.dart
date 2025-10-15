import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_model.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState()) {
    on<ToggleFavorite>((event, emit) {
      final List<Product> updatedFavorites = List.from(state.favoriteProducts);
      
      final existingProductIndex = updatedFavorites.indexWhere((p) => p.id == event.product.id);

      if (existingProductIndex >= 0) {
        updatedFavorites.removeAt(existingProductIndex);
      } else {
        updatedFavorites.add(event.product);
      }
      
      emit(FavoritesState(favoriteProducts: updatedFavorites));
    });
  }
}