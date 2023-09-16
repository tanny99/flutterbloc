import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Search Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Define variables for managing search functionality.
  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  List<String>_searchgenre=[],_searchposter=[],_searchrating=[];

  bool _isSearching = false;
  String _data = '';
  List<String> allItems=[],allgenre=[],allposter=[],allrating=[];
  Future<void> fetchData(String query) async {
    print('ji');
    print(query);
    final response = await http.get(Uri.parse('http://www.omdbapi.com/?t=$query&apikey=ee7cc67f'));
    String Genre,imdbRating,Poster;

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _data = data['Title']; // Assuming the API response has a 'title' field
        Genre = data['Genre'];
        imdbRating = data['imdbRating'];
        Poster = data['Poster'];
        allItems.add(_data);
        allposter.add(Poster);
        allrating.add(imdbRating);
        allgenre.add(Genre);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Function to perform search.
  void _performSearch(String query)async{
    await fetchData(query);
    // Simulate a search by filtering a list of items.


    setState(() {
      _searchResults = allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _searchgenre=allgenre;
      _searchposter=allposter;
      _searchrating=allrating;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {


      body: Column(
        children: [
          Padding(
            child:
          ),
          _isSearching
              ? CircularProgressIndicator() // Show a loading indicator while searching.
              : Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height:200,
                            width:200,
                            child: Image.network(_searchposter[index]),

                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(_searchResults[index],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(_searchgenre[index],style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.green
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 6.0,bottom: 6,left: 15,right: 15),
                                    child: Text(_searchrating[index]+' IMDB'),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}