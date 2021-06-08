import 'dart:convert' as convert;
import 'package:music_flutter/model/track_detail_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class TrackDetailRequest {
  Future<dynamic> getTrackDetailList(artistName) async {
    var result;
    print('开始');
    // 1.拼接URL
    final url = "http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=+$artistName+&limit=20&api_key=aa652ac51995d952d83d12093d25d9d9&format=json";
    // 2.发送请求
    try{
      var response = await http.get(Uri.parse(url),headers: {"Accept": "application/json"});
      print(response);
      if (response.statusCode == 200) {
        var json = convert.jsonDecode(response.body) as Map<String, dynamic>;
        result = json['toptracks']['track']; //不确定是不是这样
      } else {
        print('不太行');
        result =
        'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    }catch(e){
      print('e出错');
      print(e);
    }
    // 3.转成模型对象
    final subjects = result;
    List<TrackDetailModel> tracks = [];
    for (var sub in subjects) {
      tracks.add(TrackDetailModel.fromJson(sub));
    }
    return tracks;
  }
}