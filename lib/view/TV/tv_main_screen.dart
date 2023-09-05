import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/cubit/tv_popular_state.dart';
import 'package:movie_app/view/TV/tv_details_card.dart';
import 'package:movie_app/view/TV/tv_popular_widget.dart';
import '../../core/cubit/tv_state.dart';
import '../movie_details/movie_details_card.dart';
import '../now/more_now_movies.page.dart';
import 'tv_more_onAir.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../now/now_movies_card.dart';
import '../widgets/more_card.dart';
import 'tv_more_popular.dart';
import 'tv_search_movie.dart';

class MainTVScreen extends StatefulWidget {
  const MainTVScreen({Key? key}) : super(key: key);

  @override
  State<MainTVScreen> createState() => _MainTVScreenState();
}

class _MainTVScreenState extends State<MainTVScreen> {
  void initState() {
    getTv.getTvOnAir(1);
    getTvPopular.getTvPopular(1);
    super.initState();
  }

  TvCubit getTv = TvCubit();
  TvPopularCubit getTvPopular = TvPopularCubit();
  // PopularMoviesCubit popularMovies = PopularMoviesCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'TV',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TvSearchPage(),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // NOW TV WiDGEEET
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    BlocBuilder<TvCubit, TvState>(
                      bloc: getTv,
                      builder: (context, state) {
                        if (state is TvLoadingAction) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is TvSuccessAction) {
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
                                    final data = state.tvResults![index];

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TvDetailsCard(
                                                data: data,
                                              ),
                                            ));
                                      },
                                      child: NowMoviesCard(
                                        movieName: data.name!,
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
                                          builder: (context) => TvMoreOnAir(),
                                        ));
                                  },
                                  child: MoreWidget(height: 230, width: 150),
                                ),
                              ),
                            ],
                          );
                        } else if (state is TvFailureAction) {
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

            // PopUlaaaaaar TVVV Widgeeeet
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
            Column(
              children: [
                BlocBuilder<TvPopularCubit, TvPopularState>(
                  bloc: getTvPopular,
                  builder: (context, state) {
                    if (state is TvPopularLoadingAction) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is TvPopularSuccessAction) {
                      return Column(
                        children: [
                          GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisExtent: 200,
                            ),
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              final data = state.tvResults![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TvDetailsCard(
                                        data: data,
                                      ),
                                    ),
                                  );
                                },
                                child: TvPopularWidget(
                                  tvName: data.name!,
                                  urlImage: data.backdropPath!,
                                  vote: data.voteAvg,
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TvMorePopularScreen(),
                                    ));
                              },
                              child: MoreWidget(
                                  height: 150, width: double.infinity),
                            ),
                          ),
                        ],
                      );
                    } else if (state is TvPopularFailureAction) {
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
            )
          ],
        ),
      ),
    );
  }
}
