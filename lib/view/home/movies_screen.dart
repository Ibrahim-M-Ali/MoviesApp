import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/view/now/movies_search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/cubit/popular_state.dart';
import '../../core/cubit/now_state.dart';
import '../now/more_now_movies.page.dart';
import '../popular/more_popular_movies_page.dart';
import '../widgets/more_card.dart';
import '../now/now_movies_card.dart';
import 'package:shimmer/shimmer.dart';
import '../popular/popular_card.dart';
import '../movie_details/movie_details_card.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  void initState() {
    nowMovies.loadNowMovies(1);
    popularMovies.loadPopularMovies(1);
    super.initState();
  }

  NowMoviesCubit nowMovies = NowMoviesCubit();
  PopularMoviesCubit popularMovies = PopularMoviesCubit();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                // vertical: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'MOVIES',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoviesSearchPage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                      ))
                ],
              ),
            ),
          ),
          backgroundColor: const Color(0xFFF8F8F8),
          toolbarHeight: 80,
          elevation: 0,
        ),
        backgroundColor: const Color(0xFFF8F8F8),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Now',
                  style: TextStyle(
                      color: Color(
                        0xFF707070,
                      ),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              // NOW MOVIES WiDGEEET
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      BlocBuilder<NowMoviesCubit, NowMoviesState>(
                        bloc: nowMovies,
                        builder: (context, state) {
                          if (state is LoadingAction) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is SuccessAction) {
                            return Stack(
                              children: [
                                SizedBox(
                                  height: 285,
                                  width: 1275,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 6,
                                    itemBuilder: (context, index) {
                                      final data = state.results![index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MovieDetailsCard(
                                                      data: data,
                                                    )),
                                          );
                                        },
                                        child: NowMoviesCard(
                                          movieName: data.title!,
                                          urlImage: data.posterPath!,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  left: 1110,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MoreNowMoviesPage(),
                                        ),
                                      );
                                    },
                                    child: MoreWidget(
                                      height: 230,
                                      width: 150,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (state is FailureAction) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(state.errorMessage!),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Popular',
                  style: TextStyle(
                      color: Color(
                        0xFF707070,
                      ),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              // POPULAR MOVIES WiDGEEET
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
                        bloc: popularMovies,
                        builder: (context, state) {
                          if (state is PopularLoadingAction) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is PopularSuccessAction) {
                            return SizedBox(
                              height: 500,
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.bottomRight,
                                children: [
                                  GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 3 / 2,
                                    ),
                                    itemCount: 7,
                                    itemBuilder: (BuildContext ctx, index) {
                                      final data = state.results![index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MovieDetailsCard(
                                                      data: data,
                                                    )),
                                          );
                                        },
                                        child: PopularMoviesCard(
                                          movieName: data.title!,
                                          urlImage: data.posterPath!,
                                          vote: data.voteAvg.toString(),
                                          releaseDate:
                                              data.releaseDate!.substring(0, 4),
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    top: 250,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MorePopularMoviesPage(),
                                          ),
                                        );
                                      },
                                      child: MoreWidget(
                                        height: 230,
                                        width: 150,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (state is PopularFailureAction) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(state.errorMessage!),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
