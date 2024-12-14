import 'dart:convert';

class TvShowResponse {
  final double score;
  final Show show;

  TvShowResponse({required this.score, required this.show});

  // Convert JSON to TvShowResponse object
  factory TvShowResponse.fromJson(Map<String, dynamic> json) {
    return TvShowResponse(
      score: json['score']?.toDouble() ?? 0.0,  // Provide default value if null
      show: Show.fromJson(json['show'] ?? {}),  // Handle null show object safely
    );
  }
}

class Show {
  final int id;
  final String url;
  final String name;
  final String type;
  final String language;
  final List<String> genres;
  final String status;
  final int runtime;
  final int averageRuntime;
  final String premiered;
  final String? ended;
  final String officialSite;
  final Schedule schedule;
  final Rating rating;
  final int weight;
  final Network network;
  final Externals externals;
  final Image image;
  final String summary;
  final int updated;
  final Links links;

  Show({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.language,
    required this.genres,
    required this.status,
    required this.runtime,
    required this.averageRuntime,
    required this.premiered,
    this.ended,
    required this.officialSite,
    required this.schedule,
    required this.rating,
    required this.weight,
    required this.network,
    required this.externals,
    required this.image,
    required this.summary,
    required this.updated,
    required this.links,
  });

  // Convert JSON to Show object
  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'] ?? 0,  // Default to 0 if null
      url: json['url'] ?? '',  // Default to empty string if null
      name: json['name'] ?? '',  // Default to empty string if null
      type: json['type'] ?? '',  // Default to empty string if null
      language: json['language'] ?? '',  // Default to empty string if null
      genres: List<String>.from(json['genres'] ?? []),  // Default to empty list if null
      status: json['status'] ?? '',  // Default to empty string if null
      runtime: json['runtime'] ?? 0,  // Default to 0 if null
      averageRuntime: json['averageRuntime'] ?? 0,  // Default to 0 if null
      premiered: json['premiered'] ?? '',  // Default to empty string if null
      ended: json['ended'],  // Optional, leave null if not provided
      officialSite: json['officialSite'] ?? '',  // Default to empty string if null
      schedule: Schedule.fromJson(json['schedule'] ?? {}),
      rating: Rating.fromJson(json['rating'] ?? {}),
      weight: json['weight'] ?? 0,  // Default to 0 if null
      network: Network.fromJson(json['network'] ?? {}),
      externals: Externals.fromJson(json['externals'] ?? {}),
      image: Image.fromJson(json['image'] ?? {}),
      summary: json['summary'] ?? '',  // Default to empty string if null
      updated: json['updated'] ?? 0,  // Default to 0 if null
      links: Links.fromJson(json['_links'] ?? {}),
    );
  }
}

class Schedule {
  final String time;
  final List<String> days;

  Schedule({required this.time, required this.days});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      time: json['time'] ?? '',  // Default to empty string if null
      days: List<String>.from(json['days'] ?? []),  // Default to empty list if null
    );
  }
}

class Rating {
  final double average;

  Rating({required this.average});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: json['average']?.toDouble() ?? 0.0,  // Default to 0.0 if null
    );
  }
}

class Network {
  final int id;
  final String name;
  final Country country;
  final String officialSite;

  Network({
    required this.id,
    required this.name,
    required this.country,
    required this.officialSite,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'] ?? 0,  // Default to 0 if null
      name: json['name'] ?? '',  // Default to empty string if null
      country: Country.fromJson(json['country'] ?? {}),
      officialSite: json['officialSite'] ?? '',  // Default to empty string if null
    );
  }
}

class Country {
  final String name;
  final String code;
  final String timezone;

  Country({
    required this.name,
    required this.code,
    required this.timezone,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? '',  // Default to empty string if null
      code: json['code'] ?? '',  // Default to empty string if null
      timezone: json['timezone'] ?? '',  // Default to empty string if null
    );
  }
}

class Externals {
  final int? tvrage;
  final int thetvdb;
  final String imdb;

  Externals({
    this.tvrage,
    required this.thetvdb,
    required this.imdb,
  });

  factory Externals.fromJson(Map<String, dynamic> json) {
    return Externals(
      tvrage: json['tvrage'],  // Keep null if not provided
      thetvdb: json['thetvdb'] ?? 0,  // Default to 0 if null
      imdb: json['imdb'] ?? '',  // Default to empty string if null
    );
  }
}

class Image {
  final String medium;
  final String original;

  Image({
    required this.medium,
    required this.original,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      medium: json['medium'] ?? '',  // Default to empty string if null
      original: json['original'] ?? '',  // Default to empty string if null
    );
  }
}

class Links {
  final Self self;
  final Episode previousepisode;
  final Episode nextepisode;

  Links({
    required this.self,
    required this.previousepisode,
    required this.nextepisode,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: Self.fromJson(json['self'] ?? {}),
      previousepisode: Episode.fromJson(json['previousepisode'] ?? {}),
      nextepisode: Episode.fromJson(json['nextepisode'] ?? {}),
    );
  }
}

class Self {
  final String href;

  Self({required this.href});

  factory Self.fromJson(Map<String, dynamic> json) {
    return Self(href: json['href'] ?? '');  // Default to empty string if null
  }
}

class Episode {
  final String href;
  final String name;

  Episode({
    required this.href,
    required this.name,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      href: json['href'] ?? '',  // Default to empty string if null
      name: json['name'] ?? '',  // Default to empty string if null
    );
  }
}
