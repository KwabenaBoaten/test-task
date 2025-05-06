import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc_class/drink_bloc.dart';
import 'package:test_task/event/drink_event.dart';
import 'package:test_task/mainfolders/details.dart';
import 'package:test_task/repository/drinks_repository.dart';
import 'package:test_task/state/drink_state.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late DrinkBloc _drinkBloc;
  late DrinkRepository drinkRepository;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _drinkBloc = DrinkBloc(RepositoryProvider.of(context));
    drinkRepository = RepositoryProvider.of<DrinkRepository>(context);
    _drinkBloc.add(LoadDrinks());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _drinkBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _drinkBloc,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 40), // For safe area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search drinks...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (query) {
                  _drinkBloc.add(SearchDrinks(query));
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<DrinkBloc, DrinkState>(
                builder: (context, state) {
                  if (state is DrinkLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DrinkLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: state.drinks.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final drink = state.drinks[index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  Details(drink: drink),
                                ),
                              );
                            },
                            child: Card(
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
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is DrinkError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
