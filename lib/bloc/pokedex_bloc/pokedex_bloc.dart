import 'dart:async';
import 'dart:convert';
import 'package:poke_flutter/bloc/bloc_provider.dart';
import 'package:poke_flutter/bloc/pokedex_bloc/team_transformer.dart';
import 'package:poke_flutter/models/pokeTeam.dart';
import 'package:poke_flutter/models/pokedex.dart';
import 'package:poke_flutter/models/region.dart';
import 'package:rxdart/rxdart.dart';
import 'package:poke_flutter/data/poke_api_service.dart';

class PokeDexBloc  with TeamValidators implements BlocBase {
  BehaviorSubject<List<PokemonEntries>> _lisPokeMonsters = BehaviorSubject<List<PokemonEntries>>();
  BehaviorSubject<double> _pokemonsSelected = BehaviorSubject.seeded(3);
  BehaviorSubject<String> _teamName = BehaviorSubject();
  BehaviorSubject<Poke> _pokeMon = BehaviorSubject();
  BehaviorSubject<bool> _canStartCapturing = BehaviorSubject();
  BehaviorSubject<int> _numberOfPokes = BehaviorSubject.seeded(0);
  BehaviorSubject<double> _sliderState = BehaviorSubject.seeded(3);
  List<Poke> _pokemons = List();


  // sinks
  void getPokemonEntries(String regionName) async {
    List<PokemonEntries> pokeMonsters = await _getPokemonsFromRegion(regionName);
    if(pokeMonsters == null){
      _lisPokeMonsters.sink.addError("There are no pokemons!");
      return;
    }
    _lisPokeMonsters.sink.add(pokeMonsters);

  }

  void freePokemon(String pokemonName){
    _pokemons.removeWhere((poke)=> poke.pokemonName.toLowerCase() == pokemonName.toLowerCase());
    _numberOfPokes.sink.add(_pokemons.length);
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

   changeNumberOfPokemons(double numberOfPokemons){
    _pokemonsSelected.sink.add(numberOfPokemons);
  }

  bool saveTeam(){
    if(_pokemons.length >=3 &&_teamName.stream.value.isNotEmpty){
      return true;
    }

    return false;
  }


  // streams
  Stream<List<PokemonEntries>> get pokemonList => _lisPokeMonsters.stream;
  Stream<double> get numberSelectedOfPoke => _pokemonsSelected.stream;
  Stream<double> get sliderValueStream => _sliderState.stream;
  Stream<String> get teamName => _teamName.stream.transform(validateTeamName);

  Stream<bool> get isStaringCapturing => _canStartCapturing.stream;
  Stream<int> get numberOfPokemonsPicked => _numberOfPokes.stream;


  Stream<Map> get canShowInitData => Observable.combineLatest3(
      isStaringCapturing,
      numberSelectedOfPoke,
      numberOfPokemonsPicked, (isStarting,numberSelectedOfPoke,numberOfPokemonsPicked)=>
         {'isStaring':isStarting,'numberOfPokeballs':numberSelectedOfPoke,'pokemonsPicker':numberOfPokemonsPicked});


  Function(String) get changeTeamName => _teamName.sink.add;
  Function(bool) get setStartCapturing => _canStartCapturing.sink.add;
  Function(double) get setSliderValue => _sliderState.sink.add;

  void addPokemon(Poke poke){
    _pokemons.add(poke);
    _numberOfPokes.sink.add(_pokemons.length);
    if(_pokemons.length == _pokemonsSelected.value.toInt()){
      _canStartCapturing.sink.add(false);
    }
  }

  void startCapturing(){
    _canStartCapturing.sink.add(true);
    _pokemonsSelected.sink.add(_sliderState.stream.value);
  }

  void restartProcess(){
    _canStartCapturing.sink.add(true);
    _numberOfPokes.sink.add(0);
    _pokemonsSelected.sink.add(_sliderState.stream.value);
    _pokemons.clear();
  }



  @override
  void dispose() {
    _lisPokeMonsters.close();
    _pokemonsSelected.close();
    _teamName.close();
    _pokeMon.close();
    _canStartCapturing.close();
    _numberOfPokes.close();
    _sliderState.close();
  }
}
