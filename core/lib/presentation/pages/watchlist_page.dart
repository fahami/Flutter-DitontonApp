import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:tv/presentation/pages/watchlist_tvs.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';
  const WatchlistPage({Key? key}) : super(key: key);

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
        title: const Text('Watchlist'),
        bottom: TabBar(controller: controller, tabs: const [
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
          children: const [WatchlistMovies(), WatchlistTvs()],
        ),
      ),
    );
  }
}
