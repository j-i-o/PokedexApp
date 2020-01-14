import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:pokedex_app/DataLayer/Models/pokemon.dart';

class Repository {
  //Metodo para obtener todos los pokemon
  static Future<List<Pokemon>> getPokemons(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('data/pokedex_json_database.json');
    Iterable l = json.decode(jsonString);
    List<Pokemon> pokemons = l.map((model) => Pokemon.fromJson(model)).toList();
    return pokemons;
  }

  //Metodo para obtener todos los pokemon
  static Future<Pokemon> getSinglePokemon(BuildContext context, int id) async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('data/pokedex_json_database.json');
    Iterable l = json.decode(jsonString);
    Pokemon pokemon = l
        .where((x) => x["id"] == id)
        .map((model) => Pokemon.fromJson(model))
        .single;
    return pokemon;
  }
}
