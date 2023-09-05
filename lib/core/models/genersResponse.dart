class Genres {
  List<GenresRes>? genres;

  Genres({this.genres});

  Genres.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genres = <GenresRes>[];
      json['genres'].forEach((v) {
        genres!.add(GenresRes.fromJson(v));
      });
    }
  }
}

class GenresRes {
  int? id;
  String? name;

  GenresRes({this.id, this.name});

  GenresRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
