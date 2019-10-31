import 'pokemon.dart';

class PokemonSpecies {
  int baseHappiness;
  int captureRate;
  Color color;
  EvolutionChain evolutionChain;
  List<FlavorTextEntries> flavorTextEntries;
  bool formsSwitchable;
  int genderRate;
  List<Genera> genera;
  bool hasGenderDifferences;
  int hatchCounter;
  int id;
  bool isBaby;
  String name;
  List<Names> names;
  int order;
  List<PalParkEncounters> palParkEncounters;
  List<PokedexNumbers> pokedexNumbers;
  List<Varieties> varieties;

  PokemonSpecies(
      {this.baseHappiness,
        this.captureRate,
        this.color,
        this.evolutionChain,
        this.flavorTextEntries,
        this.formsSwitchable,
        this.genderRate,
        this.genera,
        this.hasGenderDifferences,
        this.hatchCounter,
        this.id,
        this.isBaby,
        this.name,
        this.names,
        this.order,
        this.palParkEncounters,
        this.pokedexNumbers,
        this.varieties});

  PokemonSpecies.fromJson(Map<String, dynamic> json) {
    baseHappiness = json['base_happiness'];
    captureRate = json['capture_rate'];
    color = json['color'] != null ? new Color.fromJson(json['color']) : null;
    evolutionChain = json['evolution_chain'] != null
        ? new EvolutionChain.fromJson(json['evolution_chain'])
        : null;
    if (json['flavor_text_entries'] != null) {
      flavorTextEntries = new List<FlavorTextEntries>();
      json['flavor_text_entries'].forEach((v) {
        flavorTextEntries.add(new FlavorTextEntries.fromJson(v));
      });
    }
    formsSwitchable = json['forms_switchable'];
    genderRate = json['gender_rate'];
    if (json['genera'] != null) {
      genera = new List<Genera>();
      json['genera'].forEach((v) {
        genera.add(new Genera.fromJson(v));
      });
    }
    hasGenderDifferences = json['has_gender_differences'];
    hatchCounter = json['hatch_counter'];
    id = json['id'];
    isBaby = json['is_baby'];
    name = json['name'];
    if (json['names'] != null) {
      names = new List<Names>();
      json['names'].forEach((v) {
        names.add(new Names.fromJson(v));
      });
    }
    order = json['order'];
    if (json['pal_park_encounters'] != null) {
      palParkEncounters = new List<PalParkEncounters>();
      json['pal_park_encounters'].forEach((v) {
        palParkEncounters.add(new PalParkEncounters.fromJson(v));
      });
    }
    if (json['pokedex_numbers'] != null) {
      pokedexNumbers = new List<PokedexNumbers>();
      json['pokedex_numbers'].forEach((v) {
        pokedexNumbers.add(new PokedexNumbers.fromJson(v));
      });
    }
    if (json['varieties'] != null) {
      varieties = new List<Varieties>();
      json['varieties'].forEach((v) {
        varieties.add(new Varieties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_happiness'] = this.baseHappiness;
    data['capture_rate'] = this.captureRate;
    if (this.color != null) {
      data['color'] = this.color.toJson();
    }
    if (this.evolutionChain != null) {
      data['evolution_chain'] = this.evolutionChain.toJson();
    }
    if (this.flavorTextEntries != null) {
      data['flavor_text_entries'] =
          this.flavorTextEntries.map((v) => v.toJson()).toList();
    }

    data['forms_switchable'] = this.formsSwitchable;
    data['gender_rate'] = this.genderRate;
    if (this.genera != null) {
      data['genera'] = this.genera.map((v) => v.toJson()).toList();
    }
    data['has_gender_differences'] = this.hasGenderDifferences;
    data['hatch_counter'] = this.hatchCounter;
    data['id'] = this.id;
    data['is_baby'] = this.isBaby;
    data['name'] = this.name;
    if (this.names != null) {
      data['names'] = this.names.map((v) => v.toJson()).toList();
    }
    data['order'] = this.order;
    if (this.palParkEncounters != null) {
      data['pal_park_encounters'] =
          this.palParkEncounters.map((v) => v.toJson()).toList();
    }
    if (this.pokedexNumbers != null) {
      data['pokedex_numbers'] =
          this.pokedexNumbers.map((v) => v.toJson()).toList();
    }
    if (this.varieties != null) {
      data['varieties'] = this.varieties.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Color {
  String name;
  String url;

  Color({this.name, this.url});

  Color.fromJson(Map<String, dynamic> json) {
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

class EvolutionChain {
  String url;

  EvolutionChain({this.url});

  EvolutionChain.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class FlavorTextEntries {
  String flavorText;

  FlavorTextEntries({this.flavorText});

  FlavorTextEntries.fromJson(Map<String, dynamic> json) {
    flavorText = json['flavor_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flavor_text'] = this.flavorText;
    return data;
  }
}

class Genera {
  String genus;

  Genera({this.genus});

  Genera.fromJson(Map<String, dynamic> json) {
    genus = json['genus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genus'] = this.genus;
    return data;
  }
}

class Names {
  String name;

  Names({this.name});

  Names.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class PalParkEncounters {
  int baseScore;
  int rate;

  PalParkEncounters({this.baseScore, this.rate});

  PalParkEncounters.fromJson(Map<String, dynamic> json) {
    baseScore = json['base_score'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_score'] = this.baseScore;
    data['rate'] = this.rate;
    return data;
  }
}

class PokedexNumbers {
  int entryNumber;
  PokemonSpecies pokedex;

  PokedexNumbers({this.entryNumber, this.pokedex});

  PokedexNumbers.fromJson(Map<String, dynamic> json) {
    entryNumber = json['entry_number'];
    pokedex =
    json['pokedex'] != null ? new PokemonSpecies.fromJson(json['pokedex']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entry_number'] = this.entryNumber;
    if (this.pokedex != null) {
      data['pokedex'] = this.pokedex.toJson();
    }
    return data;
  }
}

class Varieties {
  bool isDefault;
  PokemonRef pokemon;

  Varieties({this.isDefault, this.pokemon});

  Varieties.fromJson(Map<String, dynamic> json) {
    isDefault = json['is_default'];
    pokemon =
    json['pokemon'] != null ? new PokemonRef.fromJson(json['pokemon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_default'] = this.isDefault;
    if (this.pokemon != null) {
      data['pokemon'] = this.pokemon.toJson();
    }
    return data;
  }
}
class PokemonRef {
  String name;
  String url;

  PokemonRef({this.name, this.url});

  PokemonRef.fromJson(Map<String, dynamic> json) {
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