import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/DataLayer/Models/pokemon.dart';
import 'package:pokedex_app/DataLayer/Repository/repository.dart';

class Detail extends StatefulWidget {
  @required
  final int id;
  final String name;
  final Stat stats;
  Detail({Key key, this.id, this.name, this.stats}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  double _sizeHeight = 0;
  double _sizeWidth = 0;
  double _weightSize = 0;
  double _opactiyText = 0;
  double _opactiyPokemon = 0;
  double _pokemonSize = 0;
  List<int> _stats = [0, 0, 0, 0, 0, 0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 2500), () {
      setState(() {
        _opactiyPokemon = 1;
        _pokemonSize = 200;
      });
    }).whenComplete(() {
      Future.delayed(Duration(milliseconds: 1000), () {
        setState(() {
          _sizeHeight = 200;
          _sizeWidth = 10;
          _weightSize = 20;
          _opactiyText = 1;
        });
      });
    }).whenComplete(() {
      Future.delayed(Duration(milliseconds: 1000), () {
        setState(() {
          _stats[0] = widget.stats.hp;
          _stats[1] = widget.stats.attack;
          _stats[2] = widget.stats.defense;
          _stats[3] = widget.stats.spAttack;
          _stats[4] = widget.stats.spDefense;
          _stats[5] = widget.stats.speed;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder(
        future: Repository.getSinglePokemon(context, widget.id),
        builder: (context, snapshot) {
          Pokemon pokemon = snapshot.data;
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DetailHeader(
                    opactiyText: _opactiyText,
                    weightSize: _weightSize,
                    opactiyPokemon: _opactiyPokemon,
                    pokemonSize: _pokemonSize,
                    pokemon: pokemon,
                    sizeWidth: _sizeWidth,
                    sizeHeight: _sizeHeight),
                Types(
                  pokemon: pokemon,
                  opacity: _opactiyText,
                ),
                PokemonStats(opactiyText: _opactiyText, stats: _stats)
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

class PokemonStats extends StatelessWidget {
  const PokemonStats({
    Key key,
    @required double opactiyText,
    @required this.stats,
  })  : _opactiyText = opactiyText,
        super(key: key);

  final double _opactiyText;
  final List<int> stats;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opactiyText,
      duration: Duration(seconds: 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StatWidget(
              stat: stats[0],
              title: 'HP',
            ),
            StatWidget(
              stat: stats[1],
              title: 'Attack',
            ),
            StatWidget(
              stat: stats[2],
              title: 'Defense',
            ),
            StatWidget(
              stat: stats[3],
              title: 'Sp. Atk',
            ),
            StatWidget(
              stat: stats[4],
              title: 'Sp. Def',
            ),
            StatWidget(
              stat: stats[5],
              title: 'Speed',
            ),
          ],
        ),
      ),
    );
  }
}

class StatWidget extends StatelessWidget {
  const StatWidget({
    Key key,
    @required this.stat,
    @required this.title,
  }) : super(key: key);

  final int stat;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              title,
              style: TextStyle(
                color: Color(0xFFf5eaea),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              stat.toString(),
              style: TextStyle(
                color: Color(0xFFf5eaea),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(seconds: 1),
            width: stat * 255 / (MediaQuery.of(context).size.width * 0.6),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 20,
          ),
        ],
      ),
    );
  }
}

class Types extends StatelessWidget {
  const Types({
    Key key,
    @required this.pokemon,
    @required this.opacity,
  }) : super(key: key);

  final Pokemon pokemon;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: pokemon.type.map((t) {
            return Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF5b5656),
                      offset: Offset(0, 0),
                      spreadRadius: 5,
                      blurRadius: 0),
                  // BoxShadow(
                  //     color: Colors.black,
                  //     offset: Offset(0, 0),
                  //     spreadRadius: 1,
                  //     blurRadius: 5),
                ],
              ),
              child: Image.asset('${iconTypeValues.reverse[t]}'),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DetailHeader extends StatelessWidget {
  const DetailHeader({
    Key key,
    @required double opactiyText,
    @required double weightSize,
    @required double opactiyPokemon,
    @required double pokemonSize,
    @required this.pokemon,
    @required double sizeWidth,
    @required double sizeHeight,
  })  : _opactiyText = opactiyText,
        _weightSize = weightSize,
        _opactiyPokemon = opactiyPokemon,
        _pokemonSize = pokemonSize,
        _sizeWidth = sizeWidth,
        _sizeHeight = sizeHeight,
        super(key: key);

  final double _opactiyText;
  final double _weightSize;
  final double _opactiyPokemon;
  final double _pokemonSize;
  final Pokemon pokemon;
  final double _sizeWidth;
  final double _sizeHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: AnimatedOpacity(
                opacity: _opactiyText,
                duration: Duration(seconds: 1),
                child: Text(
                  '6.9 kg',
                  style: TextStyle(
                    color: Color(0xFF7fcd91),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
                duration: Duration(seconds: 1),
                height: _weightSize,
                width: _weightSize,
                child: Image.asset('assets/icons/weightGreen.png'),
                curve: Curves.fastOutSlowIn),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: AnimatedOpacity(
                opacity: _opactiyText,
                duration: Duration(seconds: 1),
                child: Text(
                  '15.2 lbs',
                  style: TextStyle(
                    color: Color(0xFF7fcd91),
                  ),
                ),
              ),
            ),
          ],
        ),
        Stack(
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              child: FlareActor(
                'assets/animations/pokeball.flr',
                fit: BoxFit.cover,
                animation: 'Untitled',
              ),
            ),
            AnimatedOpacity(
              opacity: _opactiyPokemon,
              duration: Duration(seconds: 1),
              child: Container(
                  height: _pokemonSize,
                  width: _pokemonSize,
                  child: pokemon.image),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                AnimatedContainer(
                    duration: Duration(seconds: 1),
                    color: Color(0xFF7fcd91),
                    width: _sizeWidth,
                    height: 1,
                    curve: Curves.fastOutSlowIn),
                AnimatedContainer(
                    duration: Duration(seconds: 1),
                    color: Color(0xFF7fcd91),
                    width: 1,
                    height: _sizeHeight - 10,
                    curve: Curves.fastOutSlowIn),
                AnimatedContainer(
                    duration: Duration(seconds: 1),
                    color: Color(0xFF7fcd91),
                    width: _sizeWidth,
                    height: 1,
                    curve: Curves.fastOutSlowIn),
              ],
            ),
            AnimatedOpacity(
              opacity: _opactiyText,
              duration: Duration(seconds: 1),
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '0.7 m',
                      style: TextStyle(
                        color: Color(0xFF7fcd91),
                      ),
                    ),
                    Text(
                      '2′04″',
                      style: TextStyle(
                        color: Color(0xFF7fcd91),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
