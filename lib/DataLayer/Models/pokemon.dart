// To parse this JSON data, do
//
//     final pokemon = pokemonFromJson(jsonString);

import 'dart:convert';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  int id;
  Name name;
  List<String> type;
  Base base;

  Pokemon({
    this.id,
    this.name,
    this.type,
    this.base,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: json["id"],
        name: Name.fromJson(json["name"]),
        type: List<String>.from(json["type"].map((x) => x)),
        base: Base.fromJson(json["base"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name.toJson(),
        "type": List<dynamic>.from(type.map((x) => x)),
        "base": base.toJson(),
      };
}

class Base {
  int hp;
  int attack;
  int defense;
  int spAttack;
  int spDefense;
  int speed;

  Base({
    this.hp,
    this.attack,
    this.defense,
    this.spAttack,
    this.spDefense,
    this.speed,
  });

  factory Base.fromJson(Map<String, dynamic> json) => Base(
        hp: json["HP"],
        attack: json["Attack"],
        defense: json["Defense"],
        spAttack: json["Sp. Attack"],
        spDefense: json["Sp. Defense"],
        speed: json["Speed"],
      );

  Map<String, dynamic> toJson() => {
        "HP": hp,
        "Attack": attack,
        "Defense": defense,
        "Sp. Attack": spAttack,
        "Sp. Defense": spDefense,
        "Speed": speed,
      };
}

class Name {
  String english;
  String japanese;
  String chinese;
  String french;

  Name({
    this.english,
    this.japanese,
    this.chinese,
    this.french,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        english: json["english"],
        japanese: json["japanese"],
        chinese: json["chinese"],
        french: json["french"],
      );

  Map<String, dynamic> toJson() => {
        "english": english,
        "japanese": japanese,
        "chinese": chinese,
        "french": french,
      };
}
