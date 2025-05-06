

import 'package:test_task/model/drink_model.dart';

abstract class DrinkState {}

class DrinkInitial extends DrinkState {}

class DrinkLoading extends DrinkState {}

class DrinkLoaded extends DrinkState {
  final List<Drink> drinks;
  DrinkLoaded(this.drinks);
}

class DrinkError extends DrinkState {
  final String message;
  DrinkError(this.message);
}
