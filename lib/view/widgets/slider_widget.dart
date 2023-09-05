import 'package:flutter/material.dart';
import '../home/movies_screen.dart';
import '../home/new_home.dart';

class SliderWidget extends StatelessWidget {
  SliderWidget({
    required this.imgUrl,
    required this.onTap,
    required this.titleText,
    required this.gradientColor,
    required this.index,
  });

  String imgUrl;
  String titleText;
  void Function()? onTap;
  Color gradientColor;
  int index;

  // List<Widget> icons = List<Widget>(3);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(imgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.grey.withOpacity(0.0),
                  gradientColor.withOpacity(0.7),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 260,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  titleText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: index == 0 ? Colors.white : Colors.transparent,
                      height: 30,
                      child: Image.asset(
                        'assets/images/mask.png',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: index == 1 ? Colors.white : Colors.transparent,
                      height: 30,
                      child: Image.asset(
                        'assets/images/mask.png',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: index == 2 ? Colors.white : Colors.transparent,
                      height: 30,
                      child: Image.asset(
                        'assets/images/mask.png',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              index == 2
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NewHome(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 180,
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
                        child: const Center(
                          child: Text(
                            'Get Started',
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: onTap,
                      child: Container(
                        height: 60,
                        width: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
