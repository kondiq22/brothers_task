import 'package:brothers_task/screens/widgets/error_dialog.dart';
import 'package:brothers_task/screens/gallery_screen.dart';

import 'package:brothers_task/screens/post_screen.dart';
import 'package:brothers_task/services/photos_api_request.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;
  bool isConnected = false;
  List<Photo>? photos;

  final List<Widget> _widgetOptions = <Widget>[
    const GalleryScreen(),
    const PostScreen(),
  ];
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Future<dynamic> checkConnection() async {
    final Connectivity connectivity = Connectivity();

    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
      return isConnected = false;
    } else {
      setState(() {
        isConnected = true;
      });
      isConnected = true;
    }
  }

  @override
  void initState() {
    checkConnection();
    isConnected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(children: <Widget>[
          Center(
            child: (isConnected)
                ? _widgetOptions.elementAt(_selectedPageIndex)
                : errorDialog(context, 'Connection Failed',
                    'Unable to connect to the Internet. Please check your connection and try again.'),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              backgroundColor: Colors.white.withOpacity(0.6),
              elevation: 0,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.image_outlined),
                  label: 'Images',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.comment_outlined),
                  label: 'Comments',
                ),
              ],
              onTap: _selectPage,
              currentIndex: _selectedPageIndex,
            ),
          ),
        ]),
      ),
    );
  }
}
