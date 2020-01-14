import 'package:flutter/material.dart';
import 'package:pokedex_app/DataLayer/Models/pokemon.dart';
import 'package:pokedex_app/DataLayer/Repository/repository.dart';

class Detail extends StatefulWidget {
  @required
  final int id;
  Detail({Key key, this.id}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Repository.getSinglePokemon(context, widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Pokemon pokemon = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(pokemon.name.english),
            ),
            body: Center(
              child: Image.network(
                  'https://assets.pokemon.com/assets/cms2/img/pokedex/full/${pokemon.id.toString().padLeft(3, '0')}.png'),
            ),
            // body: SingleChildScrollView(
            //   child: Column(
            //     children: <Widget>[
            //       Text('${pokemon.id.toString().padLeft(3, '0')}'),
            //       Row(
            //         children: pokemon.type.map((t) => Text(t)).toList(),
            //       )
            //     ],
            //   ),
            // ),
          );
        }
        return Center(
          child: Container(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
