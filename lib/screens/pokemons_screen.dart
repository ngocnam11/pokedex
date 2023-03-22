import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../sqlite/db_provider.dart';
import '../widgets/pokemon_card.dart';
import 'add_pokemon_screen.dart';
import 'search_screen.dart';

class PokemonsScreen extends StatefulWidget {
  const PokemonsScreen({super.key});

  @override
  State<PokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends State<PokemonsScreen> {
  @override
  void initState() {
    DBProvider.instance.database;
    super.initState();
  }

  @override
  void dispose() {
    DBProvider.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Pokemons'), actions: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Icon(Icons.search),
          ),
        ),
      ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: StreamBuilder<List<Pokemon>>(
          stream: DBProvider.instance.getPokemonsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error.toString());
            }
            return GridView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return PokemonCard(
                  pokemon: snapshot.data![index],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPokemonScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
