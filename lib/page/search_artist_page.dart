

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchArtistPage extends StatefulWidget{
  @override
  _SearchArtistPageState createState() => _SearchArtistPageState();
}

class _SearchArtistPageState extends State<SearchArtistPage>{
  String newSearchWords='';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getSearchBar(),

      ],
    );
  }

  // getSearchBar() {
  //   return Container(
  //     child: Row(
  //       children: [
  //         Container(
  //           width: MediaQuery.of(context).size.width-60,
  //           padding: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 10),
  //           child: ,
  //         )
  //       ],
  //     ),
  //   )
  // }

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
                      hintText: 'Search by the artist name',
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
                  // Navigator.push(
                  //   context,
                  //   new MaterialPageRoute(
                  //       builder: (BuildContext context) => SearchResultPage(
                  //           searchWords: widget.newSearchWords)),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                        size: 20,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}