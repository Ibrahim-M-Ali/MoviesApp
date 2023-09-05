class MovieVideoResponse {
  List<VideoReuslts>? results;

  MovieVideoResponse({this.results});

  MovieVideoResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <VideoReuslts>[];
      json['results'].forEach((v) {
        results!.add(new VideoReuslts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoReuslts {
  String? key;
  String? site;
  String? type;
  String? id;
  String? name;

  VideoReuslts({
    this.key,
    this.site,
    this.type,
    this.id,
    this.name,
  });

  VideoReuslts.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    site = json['site'];
    type = json['type'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['site'] = this.site;
    data['type'] = this.type;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
