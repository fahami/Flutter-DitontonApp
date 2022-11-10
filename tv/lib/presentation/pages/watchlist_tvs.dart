import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class WatchlistTvs extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tvs';

  const WatchlistTvs({super.key});

  @override
  State<WatchlistTvs> createState() => _WatchlistTvsState();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist TV'),
      ),
      body: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
        builder: (context, state) {
          if (state is WatchlistTvLoading) {
            return const Center(
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
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
