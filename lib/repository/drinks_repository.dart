import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test_task/model/drink_model.dart';


class DrinkRepository {
  Future<List<Drink>> fetchDrinks() async {
    final String response = await rootBundle.loadString('assets/json/drinks.json');
    final List<dynamic> data = json.decode(response);

    return data.map((item) => Drink.fromJson(item)).toList();
  }
}
