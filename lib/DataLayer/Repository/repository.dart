import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex_app/DataLayer/Models/pokemon.dart';

class Repository {
  static const _storage = "gs://pokedex-app-a7b1c.appspot.com";
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
    String url = await FirebaseStorage.instance
        .ref()
        .child('${pokemon.id}.png')
        .getDownloadURL();
    pokemon.image = Image.network(url);
    return pokemon;
  }
}
