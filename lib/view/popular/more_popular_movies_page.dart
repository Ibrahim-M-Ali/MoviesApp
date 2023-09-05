import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../core/cubit/popular_state.dart';
import '../movie_details/movie_details_card.dart';
import 'popular_card.dart';

class MorePopularMoviesPage extends StatefulWidget {
  @override
  State<MorePopularMoviesPage> createState() => _MorePopularMoviesPageState();
}

class _MorePopularMoviesPageState extends State<MorePopularMoviesPage> {
  int? current;
  int? pageNumber;
  int? pageResult = 10;

  PopularMoviesCubit popularMovies = PopularMoviesCubit();
  void initState() {
    popularMovies.loadPopularMovies(current = 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF8F8F8),
        toolbarHeight: 10,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Text(
                  'Back',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Popular list',
                style: TextStyle(color: Color(0xFF707070), fontSize: 20),
              ),
            ),
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
                  return Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 240,
                      ),
                      itemCount: state.results!.length,
                      itemBuilder: (context, index) {
                        final data = state.results![index];
                        pageResult = state.totalPages;
                        return SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetailsCard(
                                          data: data,
                                        )),
                              );
                            },
                            child: PopularMoviesCard(
                              movieName: data.title!,
                              urlImage: data.posterPath!,
                              vote: data.voteAvg.toString(),
                              releaseDate: data.releaseDate!.substring(0, 4),
                            ),
                          ),
                        );
                      },
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
            NumberPaginator(
              config: const NumberPaginatorUIConfig(
                buttonSelectedBackgroundColor: Color(0xFFF96C00),
                mode: ContentDisplayMode.numbers,
                height: 50,
              ),
              numberPages: pageResult!,
              onPageChange: (int index) {
                setState(() {
                  current == index;
                  popularMovies.loadPopularMovies(current = index + 1);
                });

                // handle page change...
              },
            )
          ],
        ),
      ),
    );
  }
}
