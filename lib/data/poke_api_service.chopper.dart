// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poke_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$PokemonApiService extends PokemonApiService {
  _$PokemonApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = PokemonApiService;

  Future<Response> getRegions() {
    final $url = '/region';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getRegion(String name) {
    final $url = '/region/$name';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getPokedex(String name) {
    final $url = '/pokedex/$name';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getPokemon(String name) {
    final $url = '/pokemon/$name';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getPokemonSpecie(String name) {
    final $url = '/pokemon-species/$name';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
