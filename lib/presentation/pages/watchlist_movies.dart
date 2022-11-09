import 'package:ditonton/presentation/bloc/watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMovies extends StatefulWidget {
  @override
  _WatchlistMoviesState createState() => _WatchlistMoviesState();
}

class _WatchlistMoviesState extends State<WatchlistMovies> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WatchlistBloc>().add(FetchWatchlist()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state is WatchlistLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WatchlistHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return MovieCard(movie);
            },
            itemCount: state.movies.length,
          );
        } else if (state is WatchlistError) {
          return Center(
            key: Key('error_message'),
            child: Text(state.message),
          );
        } else if (state is WatchlistEmpty) {
          return Text('Empty');
        } else {
          return Container();
        }
      },
    );
  }
}
