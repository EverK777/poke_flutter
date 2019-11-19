import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:poke_flutter/bloc/bloc_provider.dart';
import 'package:poke_flutter/bloc/pokedex_bloc/pokedex_bloc.dart';
import 'package:poke_flutter/bloc/pokedex_bloc/pokemon_detail_bloc.dart';
import 'package:poke_flutter/models/pokeTeam.dart';
import 'package:poke_flutter/models/pokedex.dart';
import 'package:poke_flutter/models/pokemon.dart';
import 'package:poke_flutter/models/pokemon_description.dart';
import 'package:poke_flutter/utils/color_list.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:ui' as mainColors;

class PokemonDetailDialog extends StatelessWidget {
  final List<PokemonEntries> pokemonEntries;
  final int currentIndex;
  final PokeDexBloc pokeDexBloc;


  PokemonDetailDialog(this.pokemonEntries, this.currentIndex, this.pokeDexBloc);

  @override
  Widget build(BuildContext context) {
    int _indexChanged = currentIndex;
    int _oldIndex = 0;

    final PokemonListBloc bloc = BlocProvider.of<PokemonListBloc>(context);
    bloc.setPokemonName(pokemonEntries[currentIndex].pokemon_species.name);
    bloc.setPokemonInfo(pokemonEntries[currentIndex].pokemon_species.name);
    bloc.setPokemonDescription(
        pokemonEntries[currentIndex].pokemon_species.name);
    final _screenSize = MediaQuery.of(context).size;
    return StreamBuilder<String>(
      stream: bloc.getBackgroundColor,
      builder: (context, snapshot) {
        Color colorChange = mainColors.Color.fromRGBO(3, 164, 244, 1.0);
        if (snapshot.hasData) {
          colorChange = ColorReferences.getColor(snapshot.data);
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: new AppBar(
            elevation: 0.0,
            backgroundColor: colorChange,
          ),
          body: Container(
            height: _screenSize.height*0.86,
            color: colorChange,
            child: Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsetsDirectional.only(
                        top: 0, bottom: 20, start: 30),
                    width: _screenSize.width,
                    height: _screenSize.height * 0.20,
                    color: colorChange,
                    child: StreamBuilder<String>(
                        stream: bloc.getPokemonName,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            );
                          }
                          return Text('');
                        })),
                Positioned(
                  top: 120.0,
                  child: Container(
                    width: _screenSize.width,
                    height: _screenSize.height * 0.66,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0)),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(45, 45, 45, 20),
                      child: StreamBuilder<PokemonDescription>(
                        stream: bloc.getPokemonDescription,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container(
                            margin: EdgeInsets.only(top: 10),
                            child: ListView(
                              children: <Widget>[
                                Text(
                                  flavorText(snapshot.data),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87),
                                ),
                                StreamBuilder<Pokemon>(
                                  stream: bloc.getPokemonInfo,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return weightAndHeightBoxWidget(
                                          snapshot.data);
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                Container(
                                  height: 45,
                                  margin: EdgeInsets.only(top: 27),
                                  child: StreamBuilder<Pokemon>(
                                    stream: bloc.getPokemonInfo,
                                    builder: (context, snapPoke){
                                      return StreamBuilder<bool>(
                                        stream: pokeDexBloc.isStaringCapturing,
                                        builder: (context, snapIsEditing){
                                          var canEdit = true;
                                          if(snapIsEditing.hasData){
                                            if(!snapIsEditing.data){
                                              canEdit = false;
                                            }
                                          }
                                          return  Visibility(
                                            visible: snapIsEditing.hasData,
                                            child: Container(
                                              margin: EdgeInsets.only(bottom: 8),
                                              child:  RaisedButton(
                                                color: Colors.redAccent ,
                                                child: Center(
                                                  child: Text(!pokemonEntries[_indexChanged].isCaptured
                                                      ?  "Capture pokemon"
                                                      :  "Free pokemon"
                                                    ,style: TextStyle(color: Colors.white),),
                                                ),
                                                elevation: 2,
                                                shape: new RoundedRectangleBorder(
                                                  borderRadius: new BorderRadius.circular(5.0),
                                                  // side: BorderSide(color: Colors.red)),
                                                ), onPressed: canEdit || pokemonEntries[_indexChanged].isCaptured ? () {
                                                if(pokemonEntries[_indexChanged].isCaptured){
                                                  //free pokemon
                                                  freePokemon(_indexChanged);
                                                }else {
                                                  //save pokemon
                                                  final Poke pokeToSave = Poke(
                                                      snapshot.data.id.toString(),
                                                      snapshot.data.name,
                                                      _getImagePath(_indexChanged),
                                                      flavorText(snapshot.data),
                                                      snapPoke.data.height.toString(),
                                                      snapPoke.data.weight.toString()
                                                  );
                                                  pokeDexBloc.setStartCapturing(true);
                                                  pokeDexBloc.addPokemon(pokeToSave);
                                                  pokemonEntries[_indexChanged].isCaptured = true;
                                                }
                                              }:null,
                                              ),
                                            )
                                          );
                                        },
                                      );
                                    },
                                  )
                                )
                              ],
                              physics: BouncingScrollPhysics(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30.0,
                  left: 0.0,
                  right: 0.0,
                  child:  Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return StreamBuilder(
                                  stream:  pokeDexBloc.numberOfPokemonsPicked ,
                                  builder: (context, _){
                                    return  !pokemonEntries[index].isCaptured ? FadeInImage.memoryNetwork(
                                        height: 150,
                                        width: 150,
                                        placeholder: kTransparentImage,
                                        image: _getImagePath(index)):
                                   Padding(
                                     padding: EdgeInsets.all(35),
                                     child:  Image.asset(
                                       'assets/images/pokeball.png',
                                       width: 150,
                                       height: 150,
                                     ),
                                   );
                                  }
                                );
                              },
                              itemCount: pokemonEntries.length,
                              layout: SwiperLayout.CUSTOM,
                              onIndexChanged: (indexChanged) {
                                var newIndex = indexChanged;
                                if (newIndex == pokemonEntries.length-1  &&
                                    _oldIndex == 0) {
                                  newIndex = indexChanged * -1;
                                }

                                if (newIndex == 0) {
                                  _indexChanged = currentIndex;
                                } else if (_oldIndex < newIndex) {
                                  _indexChanged = _indexChanged + 1;
                                } else if (_oldIndex > newIndex) {
                                  _indexChanged = _indexChanged - 1;
                                }

                                if (_indexChanged > pokemonEntries.length - 1) {
                                  _indexChanged = 0;
                                } else if (_indexChanged < 0) {
                                  _indexChanged = pokemonEntries.length - 1;
                                }

                                bloc.setPokemonName(
                                    pokemonEntries[_indexChanged].pokemon_species.name);
                                _oldIndex = indexChanged;

                                bloc.setPokemonDescription(
                                    pokemonEntries[_indexChanged].pokemon_species.name);
                                bloc.setPokemonInfo(
                                    pokemonEntries[_indexChanged].pokemon_species.name);
                              },
                              itemWidth: 150,
                              itemHeight: 150,
                              viewportFraction: 0.8,
                              customLayoutOption: CustomLayoutOption(
                                  stateCount: 3, startIndex: currentIndex - 1)
                                  .addScale([0.5, 1, 0.5], Alignment.center).addOpacity(
                                  [0.8, 1, 0.8]).addTranslate([
                                /// offset of every item
                                new Offset(-200.0, -10.0),
                                new Offset(0.0, 0.0),
                                new Offset(200.0, -10.0)
                              ]))
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget weightAndHeightBoxWidget(Pokemon pokemon) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Height",
                  style: TextStyle(color: Colors.black54, fontSize: 18)),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(pokemon.height.toString() + " Ft",
                    style: TextStyle(color: Colors.black87, fontSize: 18)),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Text("Weight",
                  style: TextStyle(color: Colors.black54, fontSize: 18)),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(pokemon.weight.toString() + " Lb",
                    style: TextStyle(color: Colors.black87, fontSize: 18)),
              )
            ],
          )
        ],
      ),
    );
  }

  void freePokemon(int index){
    pokemonEntries[index].isCaptured = false;
    pokeDexBloc.setStartCapturing(true);
    pokeDexBloc.freePokemon(pokemonEntries[index].pokemon_species.name);
  }

  String flavorText(PokemonDescription pokemonDescription) {
    for (int i = 0; i < pokemonDescription.flavorTextEntries.length; i++) {
      if (pokemonDescription.flavorTextEntries[i].language.name == "en") {
        return pokemonDescription.flavorTextEntries[i].flavorText
            .replaceAll("\n", " ");
      }
    }
    return "";
  }

  String _getImagePath(int index) {
      String pokemonUrl = pokemonEntries[index].pokemon_species.url;
      pokemonUrl =
          pokemonUrl.replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '');
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

      return imagePath;
  }
}
