import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../sqlite/db_provider.dart';
import 'pokemon_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final nameController = TextEditingController();
  bool isShowPokemon = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Pokemon'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Name',
              ),
              onFieldSubmitted: (String _) {
                if (nameController.text.isEmpty) {
                  setState(() {
                    isShowPokemon = false;
                  });
                } else {
                  setState(() {
                    isShowPokemon = true;
                  });
                }
              },
            ),
            const SizedBox(height: 4),
            isShowPokemon
                ? FutureBuilder<Pokemon>(
                    future: DBProvider.instance
                        .getPokemonByName(nameController.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        print(snapshot.error.toString());
                      }
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PokemonDetailsScreen(
                                pokemon: snapshot.data!,
                              ),
                            ),
                          );
                        },
                        leading: Image.network(
                          snapshot.data!.img,
                          width: 120,
                          height: 120,
                        ),
                        title: Text(snapshot.data!.name),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
      
    );
  }
}
