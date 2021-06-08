

class TrackDetailModel {
  String name;
  String playcount;
  String listeners;
  String mbid;
  String url;
  String streamable;
  Artist artist;
  List<TrackImage> image;
  Attr attr;

  TrackDetailModel(
      {this.name,
        this.playcount,
        this.listeners,
        this.mbid,
        this.url,
        this.streamable,
        this.artist,
        this.image,
        this.attr});

  TrackDetailModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    playcount = json['playcount'];
    listeners = json['listeners'];
    mbid = json['mbid'];
    url = json['url'];
    streamable = json['streamable'];
    artist =
    json['artist'] != null ? new Artist.fromJson(json['artist']) : null;
    if (json['image'] != null) {
      image = new List<TrackImage>();
      json['image'].forEach((v) {
        image.add(new TrackImage.fromJson(v));
      });
    }
    attr = json['@attr'] != null ? new Attr.fromJson(json['@attr']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['playcount'] = this.playcount;
    data['listeners'] = this.listeners;
    data['mbid'] = this.mbid;
    data['url'] = this.url;
    data['streamable'] = this.streamable;
    if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    if (this.attr != null) {
      data['@attr'] = this.attr.toJson();
    }
    return data;
  }
}

class Artist {
  String name;
  String mbid;
  String url;

  Artist({this.name, this.mbid, this.url});

  Artist.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mbid = json['mbid'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mbid'] = this.mbid;
    data['url'] = this.url;
    return data;
  }
}

class TrackImage {
  String text;
  String size;

  TrackImage({this.text, this.size});

  TrackImage.fromJson(Map<String, dynamic> json) {
    text = json['#text'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['#text'] = this.text;
    data['size'] = this.size;
    return data;
  }
}

class Attr {
  String rank;

  Attr({this.rank});

  Attr.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rank'] = this.rank;
    return data;
  }
}
