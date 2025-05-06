import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc_class/drink_bloc.dart';
import 'package:test_task/mainfolders/collections_folder/shop_details/shop_details.dart';
import 'package:test_task/state/drink_state.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrinkBloc, DrinkState>(
      builder: (context, state) {
        if (state is DrinkLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DrinkLoaded) {
          final shopNames = context.read<DrinkBloc>().getShopNames(); // Get the shop names after drinks are loaded

          return Scaffold(
            body: ListView.builder(
              itemCount: shopNames.length,
              itemBuilder: (context, index) {
                final shop = shopNames[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const Icon(Icons.store, size: 40),
                    title: Text(shop, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopDetails(shopName: shop),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        } else if (state is DrinkError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox(); // Placeholder for other states
      },
    );
  }
}
