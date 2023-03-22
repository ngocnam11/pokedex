class Evolution {
  Evolution({
    required this.num,
    required this.name,
  });

  String num;
  String name;

  Evolution copyWith({
    String? num,
    String? name,
  }) =>
      Evolution(
        num: num ?? this.num,
        name: name ?? this.name,
      );

  factory Evolution.fromJson(Map<String, dynamic> json) => Evolution(
        num: json["num"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "num": num,
        "name": name,
      };
}
