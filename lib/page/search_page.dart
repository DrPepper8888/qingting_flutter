


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_flutter/model/populat_artist_model.dart';
import 'package:music_flutter/network/populat_artists_request.dart';
import 'package:music_flutter/view/artist_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_flutter/page/search_artist_page.dart';
import 'package:music_flutter/page/search_track_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin{
  List<PopularArtistModel> artistsList=[];
  Future<String> futureList;
  PopularArtistsRequest _popularArtistsRequest = PopularArtistsRequest();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, initialIndex: 0, length: 2); //页面切换控制器
  }

  Future<String> getPopularList()async{
    List<PopularArtistModel> result=await  _popularArtistsRequest.getPopularArtistsList() as List<PopularArtistModel>;
    print('获取到的列表');
    print(result);
    if (result.length == 0) {
      return 'no_result';
    }
    setState(() {
      artistsList.addAll(result);
    });
    return 'have_result';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('搜索'),
          elevation: 0.7,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: "搜歌手"),
              Tab(
                text: "搜歌曲",
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),
        body: (){
          return TabBarView(
            controller: _tabController,
            children: <Widget>[
              SearchArtistPage(),
              SearchTrackPage()
            ],
          );
        }()
    );
  }

  Widget buildArtistResultList() {
    return ListView.builder(
        itemCount: artistsList.length,
        itemBuilder: (context,i)=>ArtistView(
            artistData:artistsList[i]
        ));
  }
}

