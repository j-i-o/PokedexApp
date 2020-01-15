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
  double _sizeHeight = 0;
  double _sizeWidth = 0;
  double _weightSize = 0;
  double _opactiyText = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _sizeHeight = 200;
        _sizeWidth = 10;
        _weightSize = 20;
        _opactiyText = 1;
      });
    });
  }

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
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
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
                    AnimatedOpacity(
                      opacity: _opactiyText,
                      duration: Duration(seconds: 1),
                      child: Image.network(
                        'https://assets.pokemon.com/assets/cms2/img/pokedex/full/${pokemon.id.toString().padLeft(3, '0')}.png',
                        height: 200,
                        width: 200,
                      ),
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
                                height: _sizeHeight,
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
                ),
              ],
            ),
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
