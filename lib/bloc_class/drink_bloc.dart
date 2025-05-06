import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/event/drink_event.dart';
import 'package:test_task/model/drink_model.dart';
import 'package:test_task/repository/drinks_repository.dart';
import 'package:test_task/state/drink_state.dart';

class DrinkBloc extends Bloc<DrinkEvent, DrinkState> {
  final DrinkRepository repository;
  List<Drink> _allDrinks = []; // Store the full list of drinks

  DrinkBloc(this.repository) : super(DrinkInitial()) {
    // Handle loading drinks
    on<LoadDrinks>((event, emit) async {
      emit(DrinkLoading());
      try {
        final drinks = await repository.fetchDrinks();
        _allDrinks = drinks;
        emit(DrinkLoaded(drinks));
      } catch (e) {
        emit(DrinkError("Failed to load drinks"));
      }
    });

    // Handle searching drinks
    on<SearchDrinks>((event, emit) {
      final query = event.query.toLowerCase();
      final filtered = _allDrinks.where((drink) {
        return drink.drinkName.toLowerCase().contains(query) ||
            drink.region.toLowerCase().contains(query) ||
            drink.drinkType.toLowerCase().contains(query) ||
            drink.shopName.toLowerCase().contains(query);
      }).toList();

      emit(DrinkLoaded(filtered));
    });
  }

  /// 🔍 Get a list of unique shop names from all drinks
  List<String> getShopNames() {
    final shops = _allDrinks.map((e) => e.shopName).toSet().toList();
    shops.sort();
    return shops;
  }

  List<Drink> getDrinksByShop(String shopName) {
    if (state is DrinkLoaded) {
      return (state as DrinkLoaded)
          .drinks
          .where((drink) => drink.shopName == shopName) // Match this with your model
          .toList();
    }
    return [];
  }
}


