import 'package:chopper/chopper.dart';
import 'package:rxdart/rxdart.dart';
part 'poke_api_service.chopper.dart';

@ChopperApi(baseUrl: '/region')
abstract class PokemonApiService extends ChopperService {
  @Get()
  Future<Response> getRegions();

  @Get(path: '/region/{name}')
  Future<Response> getRegion(@Path('name') String name);

  @Get(path: '/pokedex/{name}')
  Future<Response> getPokedex(@Path('name') String name);

  @Get(path: '/pokemon/{name}')
  Future<Response> getPokemon(@Path('name') String name);

  @Get(path: '/pokemon-species/{name}')
  Future<Response> getPokemonSpecie(@Path('name') String name);


  static PokemonApiService create() {
    final client = ChopperClient(
        baseUrl: 'https://pokeapi.co/api/v2',
        services: [
          _$PokemonApiService()
        ],
        converter: JsonConverter());

    return _$PokemonApiService(client);
  }

}
