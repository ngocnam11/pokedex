import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';

class DBProvider {
  static const _databaseName = 'Pokedex.db';
  static const pokemonTable = 'pokemons';

  List<Pokemon> _listPokemon = [];
  final streamController = StreamController<List<Pokemon>>.broadcast();

  DBProvider._();
  static final DBProvider instance = DBProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    _listPokemon = await getPokemons();
    streamController.sink.add(_listPokemon);
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE $pokemonTable(
          id INTEGER PRIMARY KEY,
          num TEXT,
          name TEXT,
          img TEXT,
          type TEXT,
          height TEXT,
          weight TEXT,
          candy TEXT,
          candyCount INTEGER,
          egg TEXT,
          spawnChance REAL,
          avgSpawns REAL,
          spawnTime TEXT,
          multipliers TEXT,
          weaknesses TEXT,
          nextEvolution TEXT,
          prevEvolution TEXT
        )
        ''');
      },
    );
  }

  Future<List<Pokemon>> getPokemons() async {
    final db = await instance.database;
    var res = await db.query(pokemonTable);
    final pokemons = res.map((e) => Pokemon.fromJson(e)).toList();
    return pokemons;
  }

  Future<Pokemon> getPokemonById(int id) async {
    final db = await instance.database;
    var res = await db.query(pokemonTable, where: 'id = ?', whereArgs: [id]);
    return Pokemon.fromJson(res.first);
  }

  Stream<List<Pokemon>> getPokemonsStream() {
    return streamController.stream;
  }

  Future<Pokemon> getPokemonByName(String name) async {
    final db = await instance.database;
    var res =
        await db.query(pokemonTable, where: 'name >= ?', whereArgs: [name]);
    return Pokemon.fromJson(res.first);
  }

  Future<String> addPokemon(Pokemon pokemon) async {
    String res = 'Some error occurred';
    try {
      Database db = await instance.database;
      await db.insert(pokemonTable, pokemon.toJson());
      _listPokemon.add(pokemon);
      streamController.add(_listPokemon);
      res = 'success';
    } catch (e) {
      return e.toString();
    }

    return res;
  }

  Future<String> updatePokemon(Pokemon pokemon) async {
    String res = 'Some error occurred';
    try {
      Database db = await instance.database;
      await db.update(
        pokemonTable,
        pokemon.toJson(),
        where: 'id = ?',
        whereArgs: [pokemon.id],
      );
      _listPokemon.removeWhere((element) => element.id == pokemon.id);
      _listPokemon.add(pokemon);
      streamController.add(_listPokemon);
      res = 'success';
    } catch (e) {
      return e.toString();
    }

    return res;
  }

  Future<void> deletePokemon(int id) async {
    Database db = await instance.database;
    await db.delete(
      pokemonTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    _listPokemon.removeWhere((element) => element.id == id);
    streamController.sink.add(_listPokemon);
  }

  Future<bool> close() async {
    Database db = await instance.database;
    await db.close();
    // streamController.close();
    return true;
  }
}
