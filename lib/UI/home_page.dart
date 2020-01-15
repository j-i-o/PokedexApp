import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:pokedex_app/DataLayer/Models/pokemon.dart';
import 'package:pokedex_app/DataLayer/Repository/repository.dart';
import 'package:pokedex_app/UI/detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearching = false;
  TextEditingController _searchController = TextEditingController();
  List<Pokemon> _pokemons = List<Pokemon>();
  List<Pokemon> _filteredPokemon = List<Pokemon>();

  // @override
  // void initState() async {
  //   super.initState();
  //   _pokemons = await Repository.getPokemons(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isSearching
            ? IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    isSearching = false;
                    _filteredPokemon = List<Pokemon>();
                  });
                },
              )
            : null,
        title: isSearching
            ? Row(
                children: <Widget>[
                  Icon(Icons.search),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.white),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      autofocus: true,
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          if (value != "" && _pokemons.length > 0) {
                            List<Pokemon> filter = _pokemons
                                .where(
                                  (p) => p.name.english
                                      .toLowerCase()
                                      .contains(value),
                                )
                                .toList();
                            _filteredPokemon =
                                filter.length > 0 ? filter : List<Pokemon>();
                          } else {
                            _filteredPokemon = List<Pokemon>();
                          }
                        });
                      },
                    ),
                  )
                ],
              )
            : Text('Pokedex'),
        actions: isSearching
            ? null
            : <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: Icon(Icons.search),
                )
              ],
      ),
      body: _pokemons.length > 0 && _searchController.value.text != ""
          ? GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: ListView.builder(
                itemCount: _filteredPokemon.length,
                itemBuilder: (context, index) {
                  Pokemon p = _filteredPokemon[index];
                  return PokemonListTile(pokemon: p);
                },
              ),
            )
          : FutureBuilder(
              future: Repository.getPokemons(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _pokemons = snapshot.data;
                  return GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: ListView.builder(
                      itemCount: _pokemons.length,
                      itemBuilder: (context, index) {
                        Pokemon p = _pokemons[index];
                        return PokemonListTile(pokemon: p);
                      },
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
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => QRViewExample()));
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}

class PokemonListTile extends StatelessWidget {
  const PokemonListTile({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Detail(
            id: pokemon.id,
            name: pokemon.name.english,
            stats: pokemon.stats,
          ),
        ),
      ),
      title: Text(
          '${pokemon.id.toString().padLeft(3, '0')} - ${pokemon.name.english} '),
      subtitle: pokemon.type.length > 1
          ? Text(
              '${typeValues.reverse[pokemon.type[0]]}, ${typeValues.reverse[pokemon.type[1]]}')
          : Text('${typeValues.reverse[pokemon.type[0]]}'),
    );
  }
}

class QRViewExample extends StatefulWidget {
  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scan result: $qrText'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      int pokemonId = int.tryParse(scanData);
      if (pokemonId != null) {
        if (pokemonId > 0 && pokemonId < 810) {
          controller.pauseCamera();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Detail(
                id: pokemonId,
              ),
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
