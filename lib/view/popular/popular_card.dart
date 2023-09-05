// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PopularMoviesCard extends StatelessWidget {
  String movieName;
  String urlImage;
  String vote;
  String releaseDate;

  PopularMoviesCard({
    required this.movieName,
    required this.urlImage,
    required this.vote,
    required this.releaseDate,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: "https://image.tmdb.org/t/p/original$urlImage",
            imageBuilder: (context, imageProvider) {
              return Container(
                constraints:
                    const BoxConstraints(minHeight: 230, minWidth: 170),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  image:
                      DecorationImage(fit: BoxFit.cover, image: imageProvider),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        releaseDate,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          movieName.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: FractionalOffset.centerRight,
                    end: FractionalOffset.centerLeft,
                    colors: [
                      Color(0xFFDB3069),
                      Color(0xFFF99F00),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Stack(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          vote.toString().substring(0, 1),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        ),
                        Positioned(
                          left: 11,
                          child: Text(
                            vote.toString().contains('.')
                                ? vote.toString().substring(1, 3)
                                : " .0 ",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
