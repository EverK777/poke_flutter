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
  final teamFieldText = TextEditingController();
  final List<PokemonEntries> pokemonEntries = List();

  RegionsPokeDex(this.regionName, this.imageNumber);

  @override
  Widget build(BuildContext context) {
    final PokeDexBloc pokeDexBloc = BlocProvider.of<PokeDexBloc>(context);
    pokeDexBloc.getPokemonEntries(regionName);
    final _screenSize = MediaQuery.of(context).size;
    return StreamBuilder<List<PokemonEntries>>(
      stream: pokeDexBloc.pokemonList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (pokemonEntries.isEmpty) {
            pokemonEntries.addAll(snapshot.data);
          }
        }
        return Scaffold(
            backgroundColor: Colors.white,
            body: Hero(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      actions: <Widget>[
                        StreamBuilder<bool>(
                          stream: pokeDexBloc.isStaringCapturing,
                          builder: (context, snapshot) {
                            return Center(
                                child: Visibility(
                                    visible: snapshot.hasData,
                                    child: StreamBuilder<Map>(
                                        stream: pokeDexBloc.canShowInitData,
                                        builder:
                                            (context, numberOfPokemonSnap) {
                                          if (numberOfPokemonSnap.hasData) {
                                            return Text(
                                              "${numberOfPokemonSnap.data['pokemonsPicker'].toString()}/${numberOfPokemonSnap.data['numberOfPokeballs'].toInt()}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                            );
                                          }
                                          return Container();
                                        })
                                )
                            );
                          },
                        ),
                        StreamBuilder<bool>(
                            stream: pokeDexBloc.isStaringCapturing,
                            builder: (context, snapStarting) {
                              return Visibility(
                                  visible: snapStarting.hasData,
                                  child: IconButton(
                                      icon: Icon(Icons.pets),
                                      onPressed: () {}));
                            }),
                        StreamBuilder<bool>(
                            stream: pokeDexBloc.isStaringCapturing,
                            builder: (context, snapStarting) {
                              return Visibility(
                                  visible: snapStarting.hasData,
                                  child: IconButton(
                                      icon: Icon(Icons.save),
                                      onPressed: () => pokeDexBloc.saveTeam()
                                          ? () {}
                                          : showErrorSave(context)));
                            })
                      ],
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
                    containerPage(snapshot, context, pokeDexBloc)
                  ],
                  physics: BouncingScrollPhysics(),
                ),
                tag: 'Region-pokedex-transition-$regionName'),
            floatingActionButton: Visibility(
              visible: snapshot.hasData && !snapshot.hasError,
              child: FloatingActionButton(
                elevation: 4,
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.group_work),
                onPressed: () => showAddTeamModal(context, pokeDexBloc),
              ),
            ));
      },
    );
  }

  Widget itemGenerator(PokemonSpecies pokemon, screenH, BuildContext context,
      int index, PokeDexBloc pokeDexBloc) {
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
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                      Text(
                          pokemon.name,
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 15),
                      ),
                    Flexible(
                        child: Center(
                            child: StreamBuilder(
                                stream: pokeDexBloc.isStaringCapturing,
                                builder: (context, _) {
                                  return !pokemonEntries[index].isCaptured
                                      ? FadeInImage.memoryNetwork(
                                          height: 65,
                                          width: 65,
                                          placeholder: kTransparentImage,
                                          image: imagePath,
                                        )
                                      : Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            'assets/images/pokeball.png',
                                            width: 45,
                                            height: 45,
                                          ));
                                })))
                  ],
                )),
            onTap: () {
              _goToPokemonDetail(context, index, pokeDexBloc);
            }));
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

  void showAddTeamModal(BuildContext context, PokeDexBloc bloc) {

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),
      ),
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: sheetDialogView(bloc,context),
        );
      },
    );
  }

  Widget sheetDialogView(PokeDexBloc bloc,BuildContext context) {
    return Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(25),
        child: Container(
            child: StreamBuilder<String>(
                stream: bloc.teamName,
                builder: (context, snapshotTeamName) {
                  return Column(
                    children: <Widget>[
                      TextField(
                        controller: teamFieldText,
                        decoration: InputDecoration(
                            errorText: snapshotTeamName.error,
                            hintText: 'Team name'),
                        onChanged: (text) {
                          bloc.changeTeamName(text);
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child:
                            Text('Select the number of pokemons that you want',textAlign: TextAlign.center,),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 15),
                          child: StreamBuilder<double>(
                              stream: bloc.sliderValueStream,
                              builder: (context, snapshot) {
                                int numberOfPokes = snapshot.hasData
                                    ? snapshot.data.toInt()
                                    : 3;
                                return _pokeBalls(numberOfPokes, context);
                              })),
                      // seekbar
                      Container(
                          margin: EdgeInsets.only(top: 5),
                          child: StreamBuilder<double>(
                            stream: bloc.sliderValueStream,
                            builder: (context, snapshot) {
                              double numberOfPokes = snapshot.hasData ? snapshot.data : 3.0;
                              return Center(
                                child: Slider(
                                  activeColor: Colors.redAccent,
                                  min: 3.0,
                                  max: 6.0,
                                  onChanged: (newValue) {
                                    bloc.setSliderValue(newValue);
                                  },
                                  value: numberOfPokes,
                                ),
                              );
                            },
                          )),
                      //button
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            StreamBuilder(
                              stream: bloc.isStaringCapturing,
                              builder: (context, isCapturingSnap) {
                                var canCapture = !isCapturingSnap.hasData;
                                return RaisedButton(
                                  color: Colors.redAccent,
                                  child: Center(
                                    child: Text(
                                      canCapture
                                          ? "Start to capture"
                                          : "Restart capturing",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  elevation: 4,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                    // side: BorderSide(color: Colors.red)),
                                  ),
                                  onPressed: snapshotTeamName.hasData
                                      ? () {
                                          if (!isCapturingSnap.hasData) {
                                            bloc.startCapturing();
                                          }
                                          else {
                                            pokemonEntries.forEach((poke)=>poke.isCaptured =false);
                                            bloc.restartProcess();
                                          }
                                          teamFieldText.text =
                                              snapshotTeamName.data;
                                          Navigator.of(context).pop();
                                        }
                                      : null,
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  );
                })));
  }

  Widget _pokeBalls(int numberOfPokemons,BuildContext context) {
    List<Container> pokeballs = List();
    for (int i = 0; i < numberOfPokemons; i++) {
      pokeballs.add(Container(
          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: 30,
          width: 30,
          child: Image.asset('assets/images/pokeball.png')));
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: pokeballs);
  }

  void _goToPokemonDetail(BuildContext context, int index, PokeDexBloc bloc) {
    var blocProviderCardCreate = BlocProvider(
        bloc: PokemonListBloc(),
        child: PokemonDetailDialog(pokemonEntries, index, bloc));
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true, builder: (context) => blocProviderCardCreate));
  }

  Widget containerPage(
      AsyncSnapshot snapshot, BuildContext context, PokeDexBloc bloc) {
    final screenSize = MediaQuery.of(context).size;
    if (snapshot.hasError) {
      return SliverFillRemaining(
          child: showError(snapshot.error, screenSize.height * 0.15,
              screenSize.height * 0.15));
    }
    // if the region is loading
    else if (!snapshot.hasData) {
      return SliverFillRemaining(child: showWait());
    } else {
      return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return itemGenerator(snapshot.data[index].pokemon_species,
                screenSize.height, context, index, bloc);
          }, childCount: snapshot.data.length));
    }
  }

  void showErrorSave(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Error! Please use at least 3 pokeballs and add a valid team name!',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.redAccent,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
