import 'package:ditonton/presentation/pages/watchlist_movies.dart';
import 'package:ditonton/presentation/pages/watchlist_tvs.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';
  WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        bottom: TabBar(controller: controller, tabs: [
          Tab(
            text: "Movies",
          ),
          Tab(
            text: "TV",
          ),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          controller: controller,
          children: [WatchlistMovies(), WatchlistTvs()],
        ),
      ),
    );
  }
}
