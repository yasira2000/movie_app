import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/get_popular_movies.dart';

import 'get_trending_movies_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
Future<void> main() async {
  late GetPopularMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetPopularMovies(mockMovieRepository);
  });

  final tMovieList = [
    Movie(
        id: 1,
        title: "Test Movie 1",
        overview: "Desc 1",
        posterPath: "/image1"),
    Movie(
        id: 2,
        title: "Test Movie 2",
        overview: "Desc 2",
        posterPath: "/image2"),
  ];

  // arrange
  test('should get popular movies from the repositroy', () async {
    when(mockMovieRepository.getPopularMovies())
        .thenAnswer((_) async => tMovieList);

    // act
    final result = await usecase();

    // assert
    expect(result, tMovieList);
    verify(mockMovieRepository.getPopularMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
