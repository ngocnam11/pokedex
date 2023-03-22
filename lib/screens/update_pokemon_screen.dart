import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../sqlite/db_provider.dart';
import '../utils.dart';
import '../widgets/multi_select_chip.dart';

class UpdatePokemonScreen extends StatefulWidget {
  const UpdatePokemonScreen({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  State<UpdatePokemonScreen> createState() => _UpdatePokemonScreenState();
}

class _UpdatePokemonScreenState extends State<UpdatePokemonScreen> {
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

  void initPokemonInfo() {
    numController.text = widget.pokemon.num;
    nameController.text = widget.pokemon.name;
    imgController.text = widget.pokemon.img;
    heightController.text = widget.pokemon.height;
    weightController.text = widget.pokemon.weight;
    candyController.text = widget.pokemon.candy;
    candyCountController.text = widget.pokemon.candyCount.toString();
    spawnChanceController.text = widget.pokemon.spawnChance.toString();
    avgSpawnsController.text = widget.pokemon.avgSpawns.toString();
    spawnTimeController.text = widget.pokemon.spawnTime;
    multipliersController.text = widget.pokemon.multipliers;
    nextEvolutionController.text = widget.pokemon.nextEvolution;
    prevEvolutionController.text = widget.pokemon.prevEvolution;
    types = widget.pokemon.type.split(', ');
    weaknesses = widget.pokemon.weaknesses.split(', ');
    _value = eggs.indexOf(widget.pokemon.egg);
  }

  @override
  void initState() {
    initPokemonInfo();
    super.initState();
  }

  void updatePokemon() async {
    String pokeType = types.join(', ');
    String pokeWeaknesses = weaknesses.join(', ');
    String res = await DBProvider.instance.updatePokemon(
      Pokemon(
        id: widget.pokemon.id,
        num: numController.text,
        name: nameController.text,
        img: imgController.text,
        type: pokeType,
        height: heightController.text,
        weight: weightController.text,
        candy: candyController.text,
        candyCount: int.parse(candyCountController.text),
        egg: eggs[_value!],
        spawnChance: double.parse(spawnChanceController.text),
        avgSpawns: double.parse(avgSpawnsController.text),
        spawnTime: spawnTimeController.text,
        multipliers: multipliersController.text,
        weaknesses: pokeWeaknesses,
        nextEvolution: nextEvolutionController.text,
        prevEvolution: prevEvolutionController.text,
      ),
    );

    if (!mounted) return;
    if (res == 'success') {
      showSnackBar(context, 'Updated');
      Navigator.of(context).pop();
    } else {
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Pokemon'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
            const SizedBox(height: 4),
            const Text('Pokemon\'s Type'),
            const SizedBox(height: 4),
            MultiSelectChip(
              listType: types,
              maxSelection: 5,
              onSelectionChanged: (selectedTypes) {
                setState(() {
                  types = selectedTypes;
                });
              },
            ),
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
              listType: weaknesses,
              maxSelection: 5,
              onSelectionChanged: (selectedWeaknesses) {
                setState(() {
                  weaknesses = selectedWeaknesses;
                });
              },
            ),
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
                  updatePokemon();
                },
                child: const Text('Update Pokemon'),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
