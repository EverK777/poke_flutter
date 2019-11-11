import 'dart:async';
import 'dart:convert';
import 'package:poke_flutter/bloc/bloc_provider.dart';
import 'package:poke_flutter/models/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:poke_flutter/data/poke_api_service.dart';

class RegionBloc  implements BlocBase{
  BehaviorSubject<List<Results>> _regionsCollection = BehaviorSubject<List<Results>>();
  BehaviorSubject<int> _currentPage = BehaviorSubject.seeded(0);
  BehaviorSubject<double> _pokemonsSelected = BehaviorSubject.seeded(3);

  RegionBloc(){
    initialData();
  }

  List<Results> _regionResults;

  // sinks
  void initialData() async {
    PokemonApiService.create();
    var response = await PokemonApiService.create().getRegions();
    var decodedJson = json.decode(response.bodyString);
    _regionResults = Location.fromJson(decodedJson).results;
    _regionResults.forEach((region) =>
    region.name = region.name.substring(0,1).toUpperCase() + region.name.substring(1)
    );
    _regionsCollection.sink.add(_regionResults);
  }

  void changeNumberOfPokemons(double numberOfPokemons){
    _pokemonsSelected.sink.add(numberOfPokemons);
  }


  // streams
  Stream<List<Results>> get regionList => _regionsCollection.stream;
  Stream<int> get currentPosition => _currentPage.stream;
  Stream<double> get numberSelectedOfPoke => _pokemonsSelected.stream;

  Function(int) get changePosition => _currentPage.sink.add;

  @override
  void dispose() {
    _regionsCollection.close();
    _currentPage.close();
    _pokemonsSelected.close();
  }


}
final regionListBloc = RegionBloc();

