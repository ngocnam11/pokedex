import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../sqlite/db_provider.dart';
import '../utils.dart';
import '../widgets/multi_select_chip.dart';

class AddPokemonScreen extends StatefulWidget {
  const AddPokemonScreen({super.key});

  @override
  State<AddPokemonScreen> createState() => _AddPokemonScreenState();
}

class _AddPokemonScreenState extends State<AddPokemonScreen> {
  final idController = TextEditingController();
  final numController = TextEditingController();
  final nameController = TextEditingController();
  final imgController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final candyController = TextEditingController();
  final candyCountController = TextEditingController();
  final spawnChanceController = TextEditingController();
  final avgSpawnsController = TextEditingController();
  final spawnTimeController = TextEditingController();
  final multipliersController = TextEditingController();
  final nextEvolutionController = TextEditingController();
  final prevEvolutionController = TextEditingController();
  int? _value = 0;
  List<String> eggs = ["Not in Eggs", "Omanyte Candy", "10 km", "5 km", "2 km"];
  List<String> types = [];
  List<String> weaknesses = [];

  void createPokemon() async {
    String pokeType = types.join(', ');
    String pokeWeaknesses = weaknesses.join(', ');
    String res = await DBProvider.instance.addPokemon(
      Pokemon(
        id: int.parse(idController.text) ,
        num: numController.text,
        name: nameController.text,
        img: imgController.text,
        type: pokeType,
        height: heightController.text,
        weight: weightController.text,
        candy: candyController.text,
        candyCount: int.parse(candyCountController.text) ,
        egg: eggs[_value!],
        spawnChance: double.parse(spawnChanceController.text) ,
        avgSpawns: double.parse(avgSpawnsController.text) ,
        spawnTime: spawnTimeController.text,
        multipliers: multipliersController.text,
        weaknesses: pokeWeaknesses,
        nextEvolution: nextEvolutionController.text,
        prevEvolution: prevEvolutionController.text,
      ),
    );

    if (!mounted) return;
    if(res == 'success') {
      showSnackBar(context, 'Added');
      Navigator.of(context).pop();
    } else {
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Pokemon'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Id',
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: numController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Number',
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Name',
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: imgController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Image',
              ),
            ),
            const SizedBox(height: 4),
            const Text('Pokemon\'s Type'),
            const SizedBox(height: 4),
            MultiSelectChip(
              maxSelection: 5,
              onSelectionChanged: (selectedTypes) {
                setState(() {
                  types = selectedTypes;
                });
              },
            ),
            const SizedBox(height: 4),
            TextField(
              controller: heightController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Height',
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Weight',
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: candyController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Candy',
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: candyCountController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Candy Count',
              ),
            ),
            const SizedBox(height: 4),
            const Text('Egg'),
            const SizedBox(height: 4),
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                eggs.length,
                (int index) {
                  return ChoiceChip(
                    label: Text(eggs[index]),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                      });
                    },
                    selectedColor: Colors.blue,
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: spawnChanceController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Spawn Chance',
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: avgSpawnsController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Avg Spawns',
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: spawnTimeController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Spawn Time',
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: multipliersController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Multipliers',
              ),
            ),
            const SizedBox(height: 4),
            const Text('Pokemon\'s Weakness'),
            const SizedBox(height: 4),
            MultiSelectChip(
              maxSelection: 5,
              onSelectionChanged: (selectedWeaknesses) {
                setState(() {
                  weaknesses = selectedWeaknesses;
                });
              },
            ),
            const SizedBox(height: 4),
            TextField(
              controller: nextEvolutionController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Next Evolution',
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: prevEvolutionController,
              decoration: const InputDecoration(
                hintText: 'Enter Pokemon Previous Evolution',
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  createPokemon();
                },
                child: const Text('Add Pokemon'),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
