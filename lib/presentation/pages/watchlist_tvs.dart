import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTvs extends StatefulWidget {
  @override
  _WatchlistTvsState createState() => _WatchlistTvsState();
}

class _WatchlistTvsState extends State<WatchlistTvs> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTvNotifier>(context, listen: false)
            .fetchWatchlistTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistTvNotifier>(
      builder: (context, data, child) {
        if (data.watchlistState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.watchlistState == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tv = data.watchlistTvs[index];
              return TvCard(tv);
            },
            itemCount: data.watchlistTvs.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }
}
