class Pokemon {
  final int id;
  final String num;
  final String name;
  final String img;
  final String type;
  final String height;
  final String weight;
  final String candy;
  final int candyCount;
  final String egg;
  final double spawnChance;
  final double avgSpawns;
  final String spawnTime;
  final String multipliers;
  final String weaknesses;
  final String nextEvolution;
  final String prevEvolution;

  Pokemon({
    required this.id,
    required this.num,
    required this.name,
    required this.img,
    required this.type,
    required this.height,
    required this.weight,
    required this.candy,
    required this.candyCount,
    required this.egg,
    required this.spawnChance,
    required this.avgSpawns,
    required this.spawnTime,
    required this.multipliers,
    required this.weaknesses,
    required this.nextEvolution,
    required this.prevEvolution,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: json["id"],
        num: json["num"],
        name: json["name"],
        img: json["img"],
        type: json["type"],
        height: json["height"],
        weight: json["weight"],
        candy: json["candy"],
        candyCount: json["candyCount"],
        egg: json["egg"],
        spawnChance: json["spawnChance"]?.toDouble(),
        avgSpawns: json["avgSpawns"]?.toDouble(),
        spawnTime: json["spawnTime"],
        multipliers: json["multipliers"],
        weaknesses: json["weaknesses"],
        nextEvolution: json["nextEvolution"],
        prevEvolution: json["prevEvolution"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "num": num,
        "name": name,
        "img": img,
        "type": type,
        "height": height,
        "weight": weight,
        "candy": candy,
        "candyCount": candyCount,
        "egg": egg,
        "spawnChance": spawnChance,
        "avgSpawns": avgSpawns,
        "spawnTime": spawnTime,
        "multipliers": multipliers,
        "weaknesses": weaknesses,
        "nextEvolution": nextEvolution,
        "prevEvolution": prevEvolution,
      };
}
