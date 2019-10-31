
import 'dart:convert';

import 'package:poke_flutter/bloc/bloc_provider.dart';
import 'package:poke_flutter/models/pokemon.dart';
import 'package:rxdart/rxdart.dart';
import 'package:poke_flutter/data/poke_api_service.dart';

class PokemonListBloc implements BlocBase{
  BehaviorSubject<String> _pokemonName = BehaviorSubject<String>();
  BehaviorSubject<Pokemon> _pokemonInfo = BehaviorSubject<Pokemon>();



  void setPokemonName(String name){
    if(name !=null){
      _pokemonName.sink.add(name);
    }
  }

  void setPokemonInfo(String pokemonName) async{
    final pokeName = pokemonName.toLowerCase();
    final response = await PokemonApiService.create().getPokemon(pokeName);
    var decodedJson = json.decode(response.bodyString);
    final Pokemon pokeInfo = Pokemon.fromJson(decodedJson);
    _pokemonInfo.sink.add(pokeInfo);

  }

  // streams
  Stream<String> get getPokemonName => _pokemonName.stream;
  Stream<Pokemon> get getPokemonInfo => _pokemonInfo.stream;



  @override
  void dispose() {
    _pokemonName.close();
    _pokemonInfo.close();
  }
}