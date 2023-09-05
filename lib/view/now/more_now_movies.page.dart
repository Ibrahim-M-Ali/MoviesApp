import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../movie_details/movie_details_card.dart';
import 'now_movies_card.dart';
import '../../core/cubit/now_state.dart';

import 'package:number_paginator/number_paginator.dart';

class MoreNowMoviesPage extends StatefulWidget {
  @override
  State<MoreNowMoviesPage> createState() => _MoreNowMoviesPageState();
}

class _MoreNowMoviesPageState extends State<MoreNowMoviesPage> {
  int? current;
  int? pageNumber;
  int? pageResult = 10;
  NowMoviesCubit nowMovies = NowMoviesCubit();
  @override
  void initState() {
    nowMovies.loadNowMovies(current = 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F8),
        toolbarHeight: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                'Now list',
                style: TextStyle(color: Color(0xFF707070), fontSize: 20),
              ),
            ),
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
                  return Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 300,
                      ),
                      itemCount: state.results!.length,
                      itemBuilder: (context, index) {
                        final data = state.results![index];
                        pageResult = state.totalPages;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDetailsCard(
                                        data: data,
                                      )),
                            );
                          },
                          child: NowMoviesCard(
                            movieName: state.results![index].title ?? '',
                            urlImage: state.results![index].posterPath ?? " ",
                          ),
                        );
                      },
                    ),
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
                  nowMovies.loadNowMovies(current = index + 1);
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
