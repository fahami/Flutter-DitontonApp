import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvs.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowAiringTvs = <Tv>[];
  List<Tv> get nowAiringTvs => _nowAiringTvs;

  RequestState _airingState = RequestState.Empty;
  RequestState get airingState => _airingState;

  var _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;

  RequestState _popularTvsState = RequestState.Empty;
  RequestState get popularTvsState => _popularTvsState;

  var _topRatedTvs = <Tv>[];
  List<Tv> get topRatedTvs => _topRatedTvs;

  RequestState _topRatedTvsState = RequestState.Empty;
  RequestState get topRatedTvsState => _topRatedTvsState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getAiringTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  });

  final GetAiringTvs getAiringTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;

  Future<void> fetchAiringTvs() async {
    _airingState = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTvs.execute();
    result.fold(
      (failure) {
        _airingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _airingState = RequestState.Loaded;
        _nowAiringTvs = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvs() async {
    _popularTvsState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold(
      (failure) {
        _popularTvsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _popularTvsState = RequestState.Loaded;
        _popularTvs = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvs() async {
    _topRatedTvsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();
    result.fold(
      (failure) {
        _topRatedTvsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _topRatedTvsState = RequestState.Loaded;
        _topRatedTvs = tvsData;
        notifyListeners();
      },
    );
  }
}
