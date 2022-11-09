import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/tv_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTV = Tv(
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  overview:
      "Based on the Pretty Little Liars series of young adult novels by Sara Shepard",
  popularity: 47.432451,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  voteAverage: 7.2,
  voteCount: 13507,
  firstAirDate: "2010-06-08",
  name: "Pretty Little Liars",
  originalLanguage: 'id',
  originalName: 'Pretty si tukang bohong',
  originCountry: ["ID"],
);

final testMovieList = [testMovie];
final testTVList = [testTV];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTVDetail = TvDetail(
  name: 'Bajaj Bajuri',
  firstAirDate: "2011-04-17",
  lastAirDate: "2019-05-19",
  originCountry: ["ID"],
  originalLanguage: "id",
  originalName: "Bajaj Bajuri Series",
  popularity: 2799.590,
  backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
  genres: [
    Genre(id: 1, name: 'Action'),
    Genre(id: 18, name: 'Sci-Fi'),
    Genre(id: 19, name: 'Drama'),
  ],
  id: 176,
  overview: "In the aftermath of the devastating attack on King",
  posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  voteAverage: 4.3,
  voteCount: 1234234,
  seasons: [],
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTV = Tv.watchlist(
  id: 176,
  name: 'Bajaj Bajuri',
  posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  overview: "In the aftermath of the devastating attack on King",
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVTable = TvTable(
  id: 176,
  name: 'Bajaj Bajuri',
  posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  overview: "In the aftermath of the devastating attack on King",
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTVMap = {
  'id': 176,
  'overview': "In the aftermath of the devastating attack on King",
  'posterPath': "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  'name': 'Bajaj Bajuri',
};
