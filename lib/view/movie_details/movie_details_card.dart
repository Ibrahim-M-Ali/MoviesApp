import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/core/Api/api_services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/cubit/fullcast_state.dart';
import '../../core/cubit/genres_state.dart';
import '../../core/models/now_movies_response.dart';
import '../../core/models/video_response.dart';

class MovieDetailsCard extends StatefulWidget {
  dynamic data;

  MovieDetailsCard({required this.data});

  @override
  State<MovieDetailsCard> createState() => _MovieDetailsCardState();
}

class _MovieDetailsCardState extends State<MovieDetailsCard> {
  FullCastCubit fullCastCubit = FullCastCubit();
  MovieGenres movieGenres = MovieGenres();
  @override
  void initState() {
    var dataResponse = widget.data!;
    fullCastCubit.loadFullCast(dataResponse.id!);
    movieGenres.loadMovieGenres(dataResponse.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dataResponse = widget.data!;
    // var key = ApiServices.getMovieVideo(dataResponse.id!);
    dynamic vote = dataResponse.voteAvg;

    return Scaffold(
      body: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 460,
                        // color: Colors.red,
                      ),
                      Container(
                        height: 350,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/original${dataResponse.backdropPath}',
                          fit: BoxFit.cover,
                          // placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    size: 25,
                                  ),
                                  color: Colors.white,
                                ),
                                const Text(
                                  'Back',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: const LinearGradient(
                                  begin: FractionalOffset.centerRight,
                                  end: FractionalOffset.centerLeft,
                                  colors: [
                                    Color(0xFFDB3069),
                                    Color(0xFFF99F00),
                                  ],
                                ),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  String? key = await ApiServices.getMovieVideo(
                                      dataResponse.id);
                                  String url =
                                      'https://www.youtube.com/watch?v=$key';
                                  print(key);
                                  try {
                                    await launchUrl(Uri.parse(url));
                                  } catch (e) {
                                    print('Could not launch $e');
                                  }
                                },
                                iconSize: 30,
                                icon: const Icon(Icons.play_arrow_rounded),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 140,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 150),
                            child: Text(
                              dataResponse.name!.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 200,
                              width: 130,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(0, 7),
                                  ),
                                ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original${dataResponse.posterPath}',
                                  fit: BoxFit.cover,
                                  // placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 80),
                                Text(
                                  '${dataResponse.popularity!.floor()} People watching',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                BlocBuilder<MovieGenres, MovieGenresState>(
                                  bloc: movieGenres,
                                  builder: (context, state) {
                                    if (state is SuccessAction) {
                                      return SizedBox(
                                        height: 20,
                                        width: 220,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      state.results?.length ??
                                                          0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Text(
                                                        '${state.results![index].name}, ');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Text(' ');
                                    }
                                  },
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: SizedBox(
                                        width: 23,
                                        height: 23,
                                        child: Stack(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              vote.toString().substring(0, 1),
                                              style: const TextStyle(
                                                  color: Color(0xFFD6182A),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Positioned(
                                              left: 10,
                                              bottom: 5,
                                              child: Text(
                                                vote.toString().contains('.')
                                                    ? vote
                                                        .toString()
                                                        .substring(1, 3)
                                                    : " .0 ",
                                                style: const TextStyle(
                                                    color: Color(0xFFD6182A),
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    RatingBar.builder(
                                      itemSize: 25,
                                      unratedColor: const Color(0xFF979797),
                                      initialRating:
                                          double.parse('${vote.floor() / 2}'),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star_rate_rounded,
                                        color: Color(0xFFD6182A),
                                      ),
                                      ignoreGestures: true,
                                      onRatingUpdate: (rating) {
                                        rating = rating;
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return SizedBox(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        dataResponse.name!.toUpperCase(),
                                        style: const TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.close))
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original${dataResponse.backdropPath}',
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      constraints: const BoxConstraints(
                                          maxHeight: 180,
                                          minHeight: 180,
                                          minWidth: double.infinity),
                                      // width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            image: imageProvider),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: ListView(
                                    children: [
                                      Text(
                                        dataResponse.overview!,
                                        style: const TextStyle(fontSize: 19),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  height: 140,
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    dataResponse.overview!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: const TextStyle(fontSize: 19),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                height: 50,
                color: const Color(0xFFF8F8F8),
                width: double.infinity,
                child: const Text('Full Cast & Crew'),
              ),
              BlocBuilder<FullCastCubit, FullCastState>(
                bloc: fullCastCubit,
                builder: (context, state) {
                  if (state is CastLoadingAction) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is CastSuccessAction) {
                    return Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: double.infinity,
                      height: 230,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.cast?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 160,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        offset: const Offset(0, 7),
                                      ),
                                    ],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original/${state.cast![index].profilePath}',
                                      fit: BoxFit.cover,
                                      // placeholder: (context, url) => CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    state.cast![index].originalName!,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Color(0xFF222222)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is CastFailureAction) {
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
    );
  }
}
