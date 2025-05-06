import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc_class/drink_bloc.dart';
// Update with your actual path

class ShopDetails extends StatelessWidget {
  final String shopName;

  const ShopDetails({super.key, required this.shopName});

  @override
  Widget build(BuildContext context) {
    final drinks = context.read<DrinkBloc>().getDrinksByShop(shopName); // Add this method to your DrinkBloc

    return Scaffold(
      appBar: AppBar(
        title: Text(shopName,style:const TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
      ),
      body: drinks.isEmpty
          ? const Center(child: Text("No drinks found in this shop"))
          : GridView.builder(
        itemCount: drinks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final drink = drinks[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      drink.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        drink.drinkName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${drink.ageStatement} • ${drink.region}",
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
