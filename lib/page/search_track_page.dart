import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_flutter/model/track_detail_from_search_model.dart';
import 'package:music_flutter/model/track_detail_model.dart';
import 'package:music_flutter/network/search_artist_request.dart';
import 'package:music_flutter/page/search_page.dart';
import 'package:music_flutter/view/artist_view.dart';
import 'package:music_flutter/network/search_track_request.dart';
import 'package:music_flutter/view/track_view_from_search.dart';

class SearchTrackPage extends StatefulWidget {
  SearchTrackPage({Key key}) : super(key: key);

  @override
  _SearchTrackPageState createState() => _SearchTrackPageState();
}

class _SearchTrackPageState extends State<SearchTrackPage> {
  String newSearchWords = '';
  Future<String> futureTrackResultList;
  SearchTrackRequest _searchTrackRequest = SearchTrackRequest();
  List<TrackDetailFromSearchModel> trackResultList = [];
  List<Widget> todoFutureBuilder = [];

  @override
  void initState() {
    todoFutureBuilder.add(Container(height: 10,));
    super.initState();
  }

  Future<String> getSearchTrackResultList() async {  //用于从api获取数据的异步方法
    List<TrackDetailFromSearchModel> result =
    await _searchTrackRequest.getSearchTrackResultList(newSearchWords);
    print(result);
    if (result.length == 0) {
      return 'no_result';
    }
    setState(() {
      trackResultList.addAll(result);
    });
    return 'have_result';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          getSearchBar(),
          Expanded(
            child: Column(
              children: todoFutureBuilder,
            ),
          )
        ],
      ),
    );
  }

  buildTrackResultList() {  //构建结果的listview
    return ListView.builder(
        itemCount: trackResultList.length,
        itemBuilder: (context, i) =>
           TrackViewFromSearch(trackData: trackResultList[i]));
  }

  Widget getSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {
                      newSearchWords = txt;
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Input track name',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.pinkAccent.withOpacity(0.5),
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showSearchArtistResults();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    FontAwesomeIcons.search,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //problem link :https://stackoverflow.com/questions/67900571/flutter-refresh-widgets-content-but-it-remains-old-data/67900697#67900697
  showSearchArtistResults() {
    setState(() {
      todoFutureBuilder.clear();
      trackResultList.clear();
      List<Widget> newData = [Container(height: 10,)];
      newData.add(FutureBuilder(
        future: getSearchTrackResultList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            if (snapshot.data == 'have_result') {
              return Expanded(child: buildTrackResultList());
            } else {
              return Text('No Result, Please Search Again');
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ));
      todoFutureBuilder = newData;
      print(todoFutureBuilder);
    });
  }
}
