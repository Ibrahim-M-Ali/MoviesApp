import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cubit/tv_search_cubit.dart';
import '../movie_details/movie_details_card.dart';
import '../now/now_movies_card.dart';

class TvSearchPage extends StatefulWidget {
  const TvSearchPage({Key? key}) : super(key: key);

  @override
  State<TvSearchPage> createState() => _TvSearchPageState();
}

class _TvSearchPageState extends State<TvSearchPage> {
  String tvName = '';
  @override
  void initState() {
    searchTv.searchTv(tvName);
    super.initState();
  }

  TvSearchCubit searchTv = TvSearchCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF8F8F8),
        toolbarHeight: 30,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: TextField(
                onSubmitted: (value) {
                  setState(
                    () {
                      searchTv.searchTv(tvName = value);
                    },
                  );
                },
                autofocus: true,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        width: 1, color: Colors.grey.shade300), //<-- SEE HERE
                  ),
                  suffixIcon: const Icon(Icons.search),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ),
          ),
          tvName.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text('Enter a TV Name'),
                )
              : Expanded(
                  child: BlocBuilder<TvSearchCubit, TvSearchState>(
                    bloc: searchTv,
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
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 300,
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: state.results!.length,
                              itemBuilder: (context, index) {
                                final data = state.results![index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetailsCard(
                                          data: data,
                                        ),
                                      ),
                                    );
                                  },
                                  child: NowMoviesCard(
                                    movieName:
                                        state.results![index].originalName ??
                                            '',
                                    urlImage:
                                        state.results![index].posterPath ?? " ",
                                  ),
                                );
                              },
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
                ),
        ],
      ),
    );
  }
}
