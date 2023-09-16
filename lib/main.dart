import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'movierepository.dart';
import 'movie.dart';
import 'moviesearchstate.dart';
import 'moviesearchbloc.dart';
import 'moviesearchevent.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Search',
      home: BlocProvider(
        create: (context) => MovieSearchBloc(),
        child: MovieSearchScreen(),
      ),
    );
  }
}

class MovieSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final movieBloc = BlocProvider.of<MovieSearchBloc>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Align(alignment: Alignment.centerLeft,child: Text('Home',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 22),)),
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(16.0),
             child:Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              border: Border.all(
                color: Colors.grey, // Border color
                width: 2.0, // Border width
              ),
              borderRadius: BorderRadius.circular(1),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(


                  labelText: 'Search for movies',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),

                ),
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    movieBloc.add(FetchMovie(query));
                  }
                },
              ),
            ),
          ) ),


          BlocBuilder<MovieSearchBloc, MovieSearchState>(
            builder: (context, state) {
              if (state is MovieSearchLoading) {
                return CircularProgressIndicator();
              } else if (state is MovieSearchLoaded) {
                final movie = state.movie;
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
                            child: Image.network(movie.posterUrl),

                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(movie.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(movie.genre,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.green
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 6.0,bottom: 6,left: 15,right: 15),
                                    child: Text(movie.imdbRating+' IMDB'),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is MovieSearchError) {
                return Text('Error: ${state.error}');
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}