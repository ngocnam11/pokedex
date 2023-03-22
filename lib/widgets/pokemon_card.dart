import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../screens/pokemon_details_screen.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PokemonDetailsScreen(pokemon: pokemon),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            Image.network(
              pokemon.img,
              width: 120,
              height: 120,
            ),
            Text(
              pokemon.name,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
