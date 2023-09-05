import 'package:flutter/material.dart';

import '../../core/models/slider_model.dart';
import '../widgets/slider_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SliderModel> sliders = [
    SliderModel(
        imgUrl: 'assets/images/1.jpg',
        titleText: 'Get the first \n Movie &Tv infromation',
        gradientColor: Colors.red),
    SliderModel(
        imgUrl: 'assets/images/2.png',
        titleText: 'Know the movie \n is not worth watching',
        gradientColor: Colors.yellow),
    SliderModel(
        imgUrl: 'assets/images/3.png',
        titleText: 'Real-Time \n updates movie Trailer',
        gradientColor: Colors.blue),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('My Home Page'),
      // ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SliderWidget(
              imgUrl: sliders[index].imgUrl,
              titleText: sliders[index].titleText,
              gradientColor: sliders[index].gradientColor,
              index: index,
              onTap: () {
                setState(() {
                  index == 2 ? index = 0 : index++;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
