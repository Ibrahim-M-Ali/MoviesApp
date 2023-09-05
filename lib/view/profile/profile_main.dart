import 'package:flutter/material.dart';
import 'package:movie_app/core/Api/api_profile_services.dart';
// import 'package:movie_app/core/Api/api_services.dart';
import 'package:movie_app/core/Api/session.dart';

import '../../core/models/profile_details_response.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  ProfileDetailsResponse? userData;
  @override
  void initState() {
    ApiProfile.getAccoutDetails().then((data) {
      setState(() {
        userData = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(userData!.username);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(280.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                // vertical: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: userData == null
                          ? CircularProgressIndicator()
                          : Column(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/original${userData!.avatar!.tmdb!.avatarPath}')),
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  userData!.username ?? "",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                    ),
                  ),
                  Container(
                    child: TabBar(
                      indicatorWeight: 12,
                      indicator: UnderlineTabIndicator(
                        insets: const EdgeInsets.symmetric(horizontal: 35),
                        borderSide: const BorderSide(
                            color: Color(0xFFD6182A), width: 5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tabs: const [
                        Tab(
                          child: Column(
                            children: [
                              Text(
                                '3210',
                                style: TextStyle(
                                    fontSize: 21, color: Colors.black),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Favorites',
                                style: TextStyle(color: Color(0xFF999999)),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            children: [
                              Text(
                                '3210',
                                style: TextStyle(
                                    fontSize: 21, color: Colors.black),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Watching',
                                style: TextStyle(color: Color(0xFF999999)),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            children: [
                              Text(
                                '44',
                                style: TextStyle(
                                    fontSize: 21, color: Colors.black),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Comments',
                                style: TextStyle(color: Color(0xFF999999)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          backgroundColor: const Color(0xFFF8F8F8),
          toolbarHeight: 80,
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            IconButton(
              onPressed: () async {
                await SessionOpreation().performOperations();
              },
              icon: const Icon(
                Icons.ads_click,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () async {
                var data = await ApiProfile.getAccoutDetails();
                // print(data.avatar!.tmdb!.avatarPath);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
            const Icon(Icons.directions_car, size: 20),
          ],
        ),
      ),
    );
  }
}
