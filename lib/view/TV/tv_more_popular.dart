import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../core/cubit/tv_popular_state.dart';
import '../movie_details/movie_details_card.dart';

import '../../core/cubit/now_state.dart';
import 'tv_details_card.dart';
import 'tv_popular_widget.dart';

class TvMorePopularScreen extends StatefulWidget {
  @override
  State<TvMorePopularScreen> createState() => _TvMorePopularScreenState();
}

class _TvMorePopularScreenState extends State<TvMorePopularScreen> {
  int? current;
  int? pageNumber;
  int? pageResult = 10;
  TvPopularCubit getTvPopular = TvPopularCubit();
  @override
  void initState() {
    getTvPopular.getTvPopular(current = 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF8F8F8),
        toolbarHeight: 30,
        elevation: 0,
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
                'Popular list',
                style: TextStyle(color: Color(0xFF707070), fontSize: 20),
              ),
            ),
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
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisExtent: 200,
                      ),
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: state.tvResults!.length,
                      itemBuilder: (context, index) {
                        final data = state.tvResults![index];
                        pageResult = state.totalPages;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TvDetailsCard(
                                    data: data,
                                  ),
                                ));
                          },
                          child: TvPopularWidget(
                            tvName: data.name!,
                            urlImage: data.backdropPath ?? " ",
                            vote: data.voteAvg ?? " ",
                          ),
                        );
                      },
                    ),
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
                  getTvPopular.getTvPopular(current = index + 1);
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
