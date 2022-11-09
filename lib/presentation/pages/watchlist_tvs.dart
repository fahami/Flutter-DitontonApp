import 'package:ditonton/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvs extends StatefulWidget {
  @override
  _WatchlistTvsState createState() => _WatchlistTvsState();
}

class _WatchlistTvsState extends State<WatchlistTvs> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchlistTvBloc>().add(FetchWatchlistTv()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
      builder: (context, state) {
        if (state is WatchlistTvLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WatchlistTvHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tv = state.tvs[index];
              return TvCard(tv);
            },
            itemCount: state.tvs.length,
          );
        } else if (state is WatchlistTvError) {
          return Center(
            key: Key('error_message'),
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
