import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'tv_details_card.dart';
import '../../core/cubit/tv_state.dart';
import '../movie_details/movie_details_card.dart';
import '../now/now_movies_card.dart';
import '../../core/cubit/now_state.dart';

class TvMoreOnAir extends StatefulWidget {
  @override
  State<TvMoreOnAir> createState() => _TvMoreOnAirState();
}

class _TvMoreOnAirState extends State<TvMoreOnAir> {
  int? current;
  int? pageNumber;
  int? pageResult = 10;
  TvCubit getTv = TvCubit();
  @override
  void initState() {
    getTv.getTvOnAir(current = 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const Text(
                'Back',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFFF8F8F8),
        toolbarHeight: 80,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Now list',
                style: TextStyle(color: Color(0xFF707070), fontSize: 20),
              ),
            ),
            BlocBuilder<TvCubit, TvState>(
              bloc: getTv,
              builder: (context, state) {
                if (state is TvLoadingAction) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is TvSuccessAction) {
                  return Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 290,
                      ),
                      itemCount: state.tvResults!.length,
                      itemBuilder: (context, index) {
                        final data = state.tvResults![index];
                        pageResult = state.totalPages;
                        return InkWell(
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
                          child: NowMoviesCard(
                            movieName: state.tvResults![index].name ?? " ",
                            urlImage: state.tvResults![index].posterPath ?? " ",
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is TvFailureAction) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
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
                  getTv.getTvOnAir(current = index + 1);
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
