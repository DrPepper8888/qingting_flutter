class TrackDetailFromSearchModel {
  String name;
  String artist;
  String url;
  String streamable;
  String listeners;
  List<TrackImage> image;
  String mbid;

  TrackDetailFromSearchModel(
      {this.name,
        this.artist,
        this.url,
        this.streamable,
        this.listeners,
        this.image,
        this.mbid});

  TrackDetailFromSearchModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    artist = json['artist'];
    url = json['url'];
    streamable = json['streamable'];
    listeners = json['listeners'];
    if (json['image'] != null) {
      image = new List<TrackImage>();
      json['image'].forEach((v) {
        image.add(new TrackImage.fromJson(v));
      });
    }
    mbid = json['mbid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['artist'] = this.artist;
    data['url'] = this.url;
    data['streamable'] = this.streamable;
    data['listeners'] = this.listeners;
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    data['mbid'] = this.mbid;
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
