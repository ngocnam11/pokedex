import 'models.dart';

class Pokedex {
  List<Pokemon> pokemon;
  Pokedex({
    required this.pokemon,
  });

  Pokedex copyWith({
    List<Pokemon>? pokemon,
  }) =>
      Pokedex(
        pokemon: pokemon ?? this.pokemon,
      );

  factory Pokedex.fromJson(Map<String, dynamic> json) {
    return Pokedex(
      pokemon:
          List<Pokemon>.from(json['pokemon'].map((x) => Pokemon.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'pokemon': List<dynamic>.from(pokemon.map((x) => x.toJson())),
      };
}