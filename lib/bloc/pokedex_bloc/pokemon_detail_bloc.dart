
import 'dart:convert';

import 'package:poke_flutter/bloc/bloc_provider.dart';
import 'package:poke_flutter/models/pokemon.dart';
import 'package:poke_flutter/models/pokemon_description.dart';
import 'package:rxdart/rxdart.dart';
import 'package:poke_flutter/data/poke_api_service.dart';

class PokemonListBloc implements BlocBase{
  BehaviorSubject<String> _pokemonName = BehaviorSubject<String>();
  BehaviorSubject<Pokemon> _pokemonInfo = BehaviorSubject<Pokemon>();
  BehaviorSubject<PokemonDescription> _pokemonDescription = BehaviorSubject<PokemonDescription>();
  BehaviorSubject<String> _backgroundColor = BehaviorSubject<String>();


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

  void setPokemonDescription(String pokemonName) async {
    _pokemonDescription.sink.add(null);
    final pokeName = pokemonName.toLowerCase();
    final response = await PokemonApiService.create().getPokemonSpecie(pokeName);
    var decodedJson = json.decode(response.bodyString);
    final PokemonDescription pokeDescr = PokemonDescription.fromJson(decodedJson);
    _pokemonDescription.sink.add(pokeDescr);
    if(pokeDescr !=null){
      _backgroundColor.sink.add(pokeDescr.color.name);
    }
 }

  // streams
  Stream<String> get getPokemonName => _pokemonName.stream;
  Stream<Pokemon> get getPokemonInfo => _pokemonInfo.stream;
  Stream<PokemonDescription> get getPokemonDescription => _pokemonDescription.stream;
  Stream<String> get getBackgroundColor => _backgroundColor.stream;

  Stream<bool> get getFullPokemonInfo => Observable.combineLatest2(
      getPokemonInfo, getPokemonDescription, (pokeInfo,pokeDescription)=>true);



  @override
  void dispose() {
    _pokemonName.close();
    _pokemonInfo.close();
    _pokemonDescription.close();
    _backgroundColor.close();
  }
}