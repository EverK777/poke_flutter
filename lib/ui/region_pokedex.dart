import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poke_flutter/bloc/bloc_provider.dart';
import 'package:poke_flutter/bloc/pokedex_bloc/pokedex_bloc.dart';
import 'package:poke_flutter/bloc/pokedex_bloc/pokemon_detail_bloc.dart';
import 'package:poke_flutter/models/pokedex.dart';
import 'package:poke_flutter/ui/widgets/pokemon_detail_dialog.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:poke_flutter/utils/region_list_map.dart';

class RegionsPokeDex extends StatelessWidget {
  final String regionName;
  final int imageNumber;

  RegionsPokeDex(this.regionName, this.imageNumber);

  @override
  Widget build(BuildContext context) {
    final PokeDexBloc pokeDexBloc = BlocProvider.of<PokeDexBloc>(context);
    pokeDexBloc.getPokemonEntries(regionName);
    final _screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Hero(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: _screenSize.height * 0.35,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    regionName,
                    style: TextStyle(fontFamily: 'Pokemon'),
                  ),
                  background: Image.asset(RegionMaps.mapList[imageNumber],
                      fit: BoxFit.fill),
                ),
              ),
              StreamBuilder<List<PokemonEntries>>(
                  stream: pokeDexBloc.pokemonList,
                  builder: (context, snapshot) {
                    // if the region does not have pokemons
                    if (snapshot.hasError) {
                      return SliverFillRemaining(
                          child: showError(
                              snapshot.error,
                              _screenSize.height * 0.15,
                              _screenSize.height * 0.15)
                      );
                    }
                    // if the region is loading
                    else if (!snapshot.hasData) {
                      return SliverFillRemaining(
                          child: showWait());
                    } else {
                      return SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 1.0,
                            crossAxisSpacing: 1.0,
                          ),
                          delegate: SliverChildBuilderDelegate((context,
                              index) {
                            return itemGenerator(
                                snapshot.data[index].pokemon_species,
                                _screenSize.height,context, snapshot.data,index);
                          },
                              childCount: snapshot.data.length
                          )
                      );
                    }
                  }),

            ],
            physics: BouncingScrollPhysics(),
          ),
          tag: 'Region-pokedex-transition-$regionName'),
    );
  }

  Widget itemGenerator(PokemonSpecies pokemon, screenH, BuildContext context,List<PokemonEntries>pokemons,int index) {
    String pokemonUrl = pokemon.url;
    pokemonUrl =
        pokemonUrl.replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '');
    int pokemonNumber = int.parse(pokemonUrl.replaceAll('/', ''));
    String pokemonString = pokemonNumber.toString();
    if (pokemonNumber < 10) {
      pokemonString = "00$pokemonString";
    } else if (pokemonNumber > 9 && pokemonNumber < 100) {
      pokemonString = "0$pokemonString";
    }
    final imagePath =
        "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/$pokemonString.png";
    return new Container(
        child: GestureDetector(
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Center(
                      child: Text(
                        pokemon.name,
                        style: TextStyle(
                            color: Colors.black38,
                            fontFamily: 'Pokemon',
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Flexible(
                      child: Center(
                        child: FadeInImage.memoryNetwork(
                          height: 65,
                          width: 65,
                          placeholder: kTransparentImage,
                          image: imagePath,
                        ),
                      )
                  )
                ],
              )),
          onTap: ()
          {
            _goToPokemonDetail(context, pokemons,index);
          }
        )
    );
  }

  Widget showError(String message, double width, double height) {
    return Container(
      height: 15,
      width: 15,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              message,
              style: TextStyle(
                  color: Colors.red, fontSize: 25, fontFamily: 'Pokemon'),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Image.asset(
                'assets/images/pokeball.png',
                width: width,
                height: height,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showWait() {
    return Container(
      height: 25,
      width: 25,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _goToPokemonDetail(BuildContext context, List<PokemonEntries> pokemonEntries, int index) {
    var blocProviderCardCreate = BlocProvider(
      bloc: PokemonListBloc(),
      child: PokemonDetailDialog(pokemonEntries,index)
    );
    Navigator.of(context).push(
        MaterialPageRoute( fullscreenDialog: true, builder: (context) => blocProviderCardCreate));

  }
}
