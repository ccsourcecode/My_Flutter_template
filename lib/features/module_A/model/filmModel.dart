class FilmModel {
  String? _title;
  int? _episodeId;
  String? _openingCrawl;
  String? _director;
  String? _producer;
  String? _releaseDate;
  List<String>? _characters;
  List<String>? _planets;
  List<String>? _starships;
  List<String>? _vehicles;
  List<String>? _species;
  String? _created;
  String? _edited;
  String? _url;
  String? error;

  Film(
      {String? title,
      int? episodeId,
      String? openingCrawl,
      String? director,
      String? producer,
      String? releaseDate,
      List<String>? characters,
      List<String>? planets,
      List<String>? starships,
      List<String>? vehicles,
      List<String>? species,
      String? created,
      String? edited,
      String? url}) {
    if (title != null) {
      _title = title;
    }
    if (episodeId != null) {
      _episodeId = episodeId;
    }
    if (openingCrawl != null) {
      _openingCrawl = openingCrawl;
    }
    if (director != null) {
      _director = director;
    }
    if (producer != null) {
      _producer = producer;
    }
    if (releaseDate != null) {
      _releaseDate = releaseDate;
    }
    if (characters != null) {
      _characters = characters;
    }
    if (planets != null) {
      _planets = planets;
    }
    if (starships != null) {
      _starships = starships;
    }
    if (vehicles != null) {
      _vehicles = vehicles;
    }
    if (species != null) {
      _species = species;
    }
    if (created != null) {
      _created = created;
    }
    if (edited != null) {
      _edited = edited;
    }
    if (url != null) {
      _url = url;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  int? get episodeId => _episodeId;
  set episodeId(int? episodeId) => _episodeId = episodeId;
  String? get openingCrawl => _openingCrawl;
  set openingCrawl(String? openingCrawl) => _openingCrawl = openingCrawl;
  String? get director => _director;
  set director(String? director) => _director = director;
  String? get producer => _producer;
  set producer(String? producer) => _producer = producer;
  String? get releaseDate => _releaseDate;
  set releaseDate(String? releaseDate) => _releaseDate = releaseDate;
  List<String>? get characters => _characters;
  set characters(List<String>? characters) => _characters = characters;
  List<String>? get planets => _planets;
  set planets(List<String>? planets) => _planets = planets;
  List<String>? get starships => _starships;
  set starships(List<String>? starships) => _starships = starships;
  List<String>? get vehicles => _vehicles;
  set vehicles(List<String>? vehicles) => _vehicles = vehicles;
  List<String>? get species => _species;
  set species(List<String>? species) => _species = species;
  String? get created => _created;
  set created(String? created) => _created = created;
  String? get edited => _edited;
  set edited(String? edited) => _edited = edited;
  String? get url => _url;
  set url(String? url) => _url = url;

  FilmModel.withError(String errorMessage) {
    error = errorMessage;
  }

  FilmModel.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _episodeId = json['episode_id'];
    _openingCrawl = json['opening_crawl'];
    _director = json['director'];
    _producer = json['producer'];
    _releaseDate = json['release_date'];
    _characters = json['characters'];
    _planets = json['planets'];
    _starships = json['starships'];
    _vehicles = json['vehicles'];
    _species = json['species'];
    _created = json['created'];
    _edited = json['edited'];
    _url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = _title;
    data['episode_id'] = _episodeId;
    data['opening_crawl'] = _openingCrawl;
    data['director'] = _director;
    data['producer'] = _producer;
    data['release_date'] = _releaseDate;
    data['characters'] = _characters;
    data['planets'] = _planets;
    data['starships'] = _starships;
    data['vehicles'] = _vehicles;
    data['species'] = _species;
    data['created'] = _created;
    data['edited'] = _edited;
    data['url'] = _url;
    return data;
  }
}
