import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../sqlite/db_provider.dart';
import 'update_pokemon_screen.dart';

class PokemonDetailsScreen extends StatelessWidget {
  const PokemonDetailsScreen({super.key, required this.pokemon});
  final Pokemon pokemon;

  void _deletePokemon(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Pokemon'),
        content: const Text('Do you want to delete this pokemon?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black87),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              DBProvider.instance.deletePokemon(pokemon.id);
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Details'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdatePokemonScreen(
                    pokemon: pokemon,
                  ),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Icon(Icons.edit),
            ),
          ),
          InkWell(
            onTap: () {
              _deletePokemon(context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  pokemon.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Image.network(
                  pokemon.img,
                  height: 210,
                  width: 210,
                ),
              ),
              Text(
                'Type: ${pokemon.type}',
              ),
              const SizedBox(height: 8),
              Text(
                'Height: ${pokemon.height}',
              ),
              const SizedBox(height: 8),
              Text(
                'Weight: ${pokemon.weight}',
              ),
              const SizedBox(height: 8),
              Text(
                'Candy: ${pokemon.candy}',
              ),
              const SizedBox(height: 8),
              Text(
                'Candy Count: ${pokemon.candyCount}',
              ),
              const SizedBox(height: 8),
              Text(
                'Egg: ${pokemon.egg}',
              ),
              const SizedBox(height: 8),
              Text(
                'Spawn Chance: ${pokemon.spawnChance}',
              ),
              const SizedBox(height: 8),
              Text(
                'Avg Spawns: ${pokemon.avgSpawns}',
              ),
              const SizedBox(height: 8),
              Text(
                'Spwan Time: ${pokemon.spawnTime}',
              ),
              const SizedBox(height: 8),
              Text(
                'Multipliers: ${pokemon.multipliers}',
              ),
              const SizedBox(height: 8),
              Text(
                'Weaknesses: ${pokemon.weaknesses}',
              ),
              const SizedBox(height: 8),
              pokemon.nextEvolution.isEmpty
                  ? const SizedBox()
                  : Text(
                      'Next Evolution: ${pokemon.nextEvolution}',
                    ),
              const SizedBox(height: 8),
              pokemon.prevEvolution.isEmpty
                  ? const SizedBox()
                  : Text(
                      'Previous Evolution: ${pokemon.prevEvolution}',
                    ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
