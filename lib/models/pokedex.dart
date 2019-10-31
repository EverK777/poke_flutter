import 'Region.dart';

class PokeDex {
  List<Descriptions> descriptions;
  int id;
  bool isMainSeries;
  String name;
  List<Names> names;
  List<PokemonEntries> pokemon_entries;
  Region region;

  PokeDex(
      {this.descriptions,
        this.id,
        this.isMainSeries,
        this.name,
        this.names,
        this.pokemon_entries,
        this.region,
        });

  PokeDex.fromJson(Map<String, dynamic> json) {
    if (json['descriptions'] != null) {
      descriptions = new List<Descriptions>();
      json['descriptions'].forEach((v) {
        descriptions.add(new Descriptions.fromJson(v));
      });
    }
    id = json['id'];
    isMainSeries = json['is_main_series'];
    name = json['name'];
    if (json['names'] != null) {
      names = new List<Names>();
      json['names'].forEach((v) {
        names.add(new Names.fromJson(v));
      });
    }
    if (json['pokemon_entries'] != null) {
      pokemon_entries = new List<PokemonEntries>();
      json['pokemon_entries'].forEach((v) {
        pokemon_entries.add(new PokemonEntries.fromJson(v));
      });
    }
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.descriptions != null) {
      data['descriptions'] = this.descriptions.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['is_main_series'] = this.isMainSeries;
    data['name'] = this.name;
    if (this.names != null) {
      data['names'] = this.names.map((v) => v.toJson()).toList();
    }
    if (this.pokemon_entries != null) {
      data['pokemon_entries'] =
          this.pokemon_entries.map((v) => v.toJson()).toList();
    }
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    return data;
  }
}

class Descriptions {
  String description;
  Language language;

  Descriptions({this.description, this.language});

  Descriptions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    return data;
  }
}

class Language {
  String name;
  String url;

  Language({this.name, this.url});

  Language.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Names {
  Language language;
  String name;

  Names({this.language, this.name});

  Names.fromJson(Map<String, dynamic> json) {
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class PokemonEntries {
  int entryNumber;
  PokemonSpecies pokemon_species;

  PokemonEntries({this.entryNumber, this.pokemon_species});

  PokemonEntries.fromJson(Map<String, dynamic> json) {
    entryNumber = json['entry_number'];
    pokemon_species = json['pokemon_species'] != null
        ? new PokemonSpecies.fromJson(json['pokemon_species'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entry_number'] = this.entryNumber;
    if (this.pokemon_species != null) {
      data['pokemon_species'] = this.pokemon_species.toJson();
    }
    return data;
  }
}
class PokemonSpecies {
  String name;
  String url;

  PokemonSpecies({this.name, this.url});

  PokemonSpecies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}