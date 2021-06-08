class PopularArtistModel {
  String name;
  String listeners;
  String mbid;
  String url;
  String streamable;
  List<ArtistImage> image;

  PopularArtistModel(
      {this.name,
        this.listeners,
        this.mbid,
        this.url,
        this.streamable,
        this.image});

  PopularArtistModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    listeners = json['listeners'];
    mbid = json['mbid'];
    url = json['url'];
    streamable = json['streamable'];
    if (json['image'] != null) {
      image = new List<ArtistImage>();
      json['image'].forEach((v) {
        image.add(new ArtistImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['listeners'] = this.listeners;
    data['mbid'] = this.mbid;
    data['url'] = this.url;
    data['streamable'] = this.streamable;
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArtistImage {
  String text;
  String size;

  ArtistImage({this.text, this.size});

  ArtistImage.fromJson(Map<String, dynamic> json) {
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
