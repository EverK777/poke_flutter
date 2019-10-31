import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:poke_flutter/bloc/bloc_provider.dart';
import 'package:poke_flutter/bloc/pokedex_bloc/pokemon_detail_bloc.dart';
import 'package:poke_flutter/models/pokedex.dart';
import 'package:poke_flutter/models/pokemon.dart';
import 'package:transparent_image/transparent_image.dart';

class PokemonDetailDialog extends StatelessWidget {
  final List<PokemonEntries> pokemonEntries;
  final int currentIndex;

  PokemonDetailDialog( this.pokemonEntries, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    int _indexChanged = currentIndex;
    int _oldIndex = 0;
    final PokemonListBloc bloc = BlocProvider.of<PokemonListBloc>(context);
    bloc.setPokemonName(pokemonEntries[currentIndex].pokemon_species.name);

    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        height: double.infinity,
        color: Colors.lightBlue,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsetsDirectional.only(top: 0, bottom: 20, start: 30),
              width: _screenSize.width,
              height: _screenSize.height * 0.20,
              color: Colors.lightBlue,
              child:
                StreamBuilder<String>(
                 stream: bloc.getPokemonName,
                 builder: (context, snapshot) {
                   if(snapshot.hasData){
                     return Text(
                       snapshot.data,
                       style: TextStyle(
                           fontSize: 25,
                           color: Colors.white,
                           fontWeight: FontWeight.w700),
                     );
                   }
                    return Text('');
                 }
                )
            ),
            Positioned(
              top: 120.0,
              child: Container(
                width: _screenSize.width,
                height: _screenSize.height * 0.8,
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0)),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(45, 45, 0, 20),
                  child: StreamBuilder<Pokemon>(
                     stream: bloc.getPokemonInfo,
                      builder: (context,snapshot){
                       return Container(

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
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return FadeInImage.memoryNetwork(
                      height: 150,
                      width: 150,
                      placeholder: kTransparentImage,
                      image: _getImagePath(index));
                },
                itemCount: pokemonEntries.length-1,
                index: currentIndex -1,
                layout: SwiperLayout.CUSTOM,
                onIndexChanged: (index) {
                  print(index);
                  var newIndex = index;
                  if(newIndex == pokemonEntries.length-2 && _oldIndex == 0){
                    newIndex =  index * -1;
                  }

                  if(newIndex == 0){
                    _indexChanged = currentIndex;
                  }else if(_oldIndex < newIndex){
                    _indexChanged = _indexChanged +1;
                  }else if(_oldIndex > newIndex) {
                    _indexChanged =_indexChanged -1;
                  }

                  if(_indexChanged >  pokemonEntries.length-2){
                    _indexChanged = 0;
                  }else if(_indexChanged <0){
                    _indexChanged = pokemonEntries.length-2;
                  }

                  bloc.setPokemonName(pokemonEntries[_indexChanged].pokemon_species.name);
                  _oldIndex = index ;
                },
                itemWidth: 150,
                itemHeight: 150,
                viewportFraction: 0.8,
                customLayoutOption:
                    CustomLayoutOption(stateCount: 3,startIndex: currentIndex-1).addScale(
                        [0.5, 1, 0.5],
                        Alignment.center).addOpacity([0.8, 1, 0.8]).addTranslate([           /// offset of every item
                      new Offset(-200.0, -10.0),
                      new Offset(0.0, 0.0),
                      new Offset(200.0, -10.0)
                    ])
              ),
            )
          ],
        ),
      ),
    );
  }
  
  String _getImagePath(int index){
    String pokemonUrl = pokemonEntries[index].pokemon_species.url;
    pokemonUrl = pokemonUrl.replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '');
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
