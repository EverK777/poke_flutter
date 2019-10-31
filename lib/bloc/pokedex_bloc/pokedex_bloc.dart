import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:chopper/chopper.dart';
import 'package:poke_flutter/bloc/bloc_provider.dart';
import 'package:poke_flutter/models/Pokemon.dart';
import 'package:poke_flutter/models/pokedex.dart';
import 'package:poke_flutter/models/region.dart';
import 'package:rxdart/rxdart.dart';
import 'package:poke_flutter/data/poke_api_service.dart';

class PokeDexBloc implements BlocBase {
  BehaviorSubject<List<PokemonEntries>> _lisPokeMonsters = BehaviorSubject<List<PokemonEntries>>();

  // sinks
  void getPokemonEntries(String regionName) async {
    List<PokemonEntries> pokeMonsters = await _getPokemonsFromRegion(regionName);
    if(pokeMonsters == null){
      _lisPokeMonsters.sink.addError("There are no pokemons!");
      return;
    }
    _lisPokeMonsters.sink.add(pokeMonsters);
  }

  Future<List<PokemonEntries>> _getPokemonsFromRegion(String regionName) async {
    final response = await PokemonApiService.create().getRegion(regionName.toLowerCase());
    var decodedJson = json.decode(response.bodyString);
    if(Region.fromJson(decodedJson).pokedexes.length < 1){
      return null;
    }
    final String pokeDexName = Region.fromJson(decodedJson).pokedexes[0].name;
    List<PokemonEntries> pokemonEntries = await _fetchPokemonEntries(pokeDexName);
    return pokemonEntries;
  }

  Future<List<PokemonEntries>> _fetchPokemonEntries (String pokedexName)async{
    final response = await PokemonApiService.create().getPokedex(pokedexName);
    var decodedJson = json.decode(response.bodyString);
    final List<PokemonEntries> pokemonEntries= PokeDex.fromJson(decodedJson).pokemon_entries;
    pokemonEntries.forEach((pokemon)=>
      pokemon.pokemon_species.name =
          pokemon.pokemon_species.name.substring(0,1).toUpperCase() +
              pokemon.pokemon_species.name.substring(1)
    );
    return pokemonEntries;
  }

    Future<Pokemon> _fechPokemons (String pokemonName) async{
    final response = await PokemonApiService.create().getPokemon(pokemonName);
    var decodedJson = json.decode(response.bodyString);
    final Pokemon pokemon= Pokemon.fromJson(decodedJson);
    return pokemon;
  }

  // streams
  Stream<List<PokemonEntries>> get pokemonList => _lisPokeMonsters.stream;

  @override
  void dispose() {
    _lisPokeMonsters.close();
  }
}
