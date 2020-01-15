// To parse this JSON data, do
//
//     final pokemon = pokemonFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  int id;
  Name name;
  List<Type> type;
  Stat stats;
  Image image;

  Pokemon({
    this.id,
    this.name,
    this.type,
    this.stats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: json["id"],
        name: Name.fromJson(json["name"]),
        type: List<Type>.from(json["type"].map((x) => typeValues.map[x])),
        stats: Stat.fromJson(json["base"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name.toJson(),
        "type": List<dynamic>.from(type.map((x) => typeValues.reverse[x])),
        "base": stats.toJson(),
      };
}

class Stat {
  int hp;
  int attack;
  int defense;
  int spAttack;
  int spDefense;
  int speed;

  Stat({
    this.hp,
    this.attack,
    this.defense,
    this.spAttack,
    this.spDefense,
    this.speed,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
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

enum Type {
  GRASS,
  POISON,
  FIRE,
  FLYING,
  WATER,
  BUG,
  NORMAL,
  ELECTRIC,
  GROUND,
  FAIRY,
  FIGHTING,
  PSYCHIC,
  ROCK,
  STEEL,
  ICE,
  GHOST,
  DRAGON,
  DARK
}

final typeValues = EnumValues({
  "Bug": Type.BUG,
  "Dark": Type.DARK,
  "Dragon": Type.DRAGON,
  "Electric": Type.ELECTRIC,
  "Fairy": Type.FAIRY,
  "Fighting": Type.FIGHTING,
  "Fire": Type.FIRE,
  "Flying": Type.FLYING,
  "Ghost": Type.GHOST,
  "Grass": Type.GRASS,
  "Ground": Type.GROUND,
  "Ice": Type.ICE,
  "Normal": Type.NORMAL,
  "Poison": Type.POISON,
  "Psychic": Type.PSYCHIC,
  "Rock": Type.ROCK,
  "Steel": Type.STEEL,
  "Water": Type.WATER
});

final iconTypeValues = EnumValues({
  "assets/icons/bug.png": Type.BUG,
  "assets/icons/dark.png": Type.DARK,
  "assets/icons/dragon.png": Type.DRAGON,
  "assets/icons/electric.png": Type.ELECTRIC,
  "assets/icons/fairy.png": Type.FAIRY,
  "assets/icons/fighting.png": Type.FIGHTING,
  "assets/icons/fire.png": Type.FIRE,
  "assets/icons/flying.png": Type.FLYING,
  "assets/icons/ghost.png": Type.GHOST,
  "assets/icons/grass.png": Type.GRASS,
  "assets/icons/ground.png": Type.GROUND,
  "assets/icons/ice.png": Type.ICE,
  "assets/icons/normal.png": Type.NORMAL,
  "assets/icons/poison.png": Type.POISON,
  "assets/icons/psychic.png": Type.PSYCHIC,
  "assets/icons/rock.png": Type.ROCK,
  "assets/icons/steel.png": Type.STEEL,
  "assets/icons/water.png": Type.WATER
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
