// drink_event.dart
abstract class DrinkEvent {}

class LoadDrinks extends DrinkEvent {}

class SearchDrinks extends DrinkEvent {
  final String query;
  SearchDrinks(this.query);
}
