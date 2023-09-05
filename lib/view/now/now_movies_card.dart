// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NowMoviesCard extends StatelessWidget {
  String? movieName;
  String urlImage;

  NowMoviesCard({
    this.movieName,
    required this.urlImage,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 230,
            width: 170,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 7),
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/original$urlImage',
                fit: BoxFit.cover,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 7),
          Expanded(
            child: SizedBox(
              width: 150,
              child: Text(
                textAlign: TextAlign.center,
                movieName ?? "",
                maxLines: 2,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF222222)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
                    // imageUrl:'https://image.tmdb.org/t/p/original$urlImage',
