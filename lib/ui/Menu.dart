import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/ui/CostEstimatorView.dart';
import 'package:final_project/ui/CreateAccount.dart';
import 'package:final_project/ui/VideosView.dart';
import 'package:final_project/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:flutter_animated_icons/useanimations.dart';
import 'package:lottie/lottie.dart';

class Menu extends StatelessWidget{
  const Menu({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuStatefulWidget(key: super.key),
    );
  }
}

class MenuStatefulWidget extends StatefulWidget {
  const MenuStatefulWidget({super.key});

  @override
  State<MenuStatefulWidget> createState() => _MenuStatefulWidgetState();
}

class _MenuStatefulWidgetState extends State<MenuStatefulWidget> with SingleTickerProviderStateMixin{

  final List<Widget> _pages = [];
  int _value = 0;

  late AnimationController _settingController;


  //pages
  final _videosPage = VideosView();
  final _estimatorPage = CostEstimatorView();
  final _settingsPage = SettingsView();

  @override
  void initState() {
    super.initState();
    _pages.add(_videosPage);
    _pages.add(_estimatorPage);
    _pages.add(_settingsPage);

    _settingController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

  }

  @override
  void dispose() {
    _settingController.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
      return
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 52),
            child: SliderDrawer(
              appBar: const SliderAppBar(
                  appBarColor: Colors.white,
                  title: Text("test",
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700))),
              slider: Expanded(
                child: Container(color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:
                      [
                        TextButton(
                            onPressed: switchToVideos,
                            child: const Text("Videos",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30
                              ),

                            )),
                        TextButton(
                            onPressed: switchToEstimator,
                            child: const Text("Cost Estimator",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30
                              ),

                            )),
                        Padding(padding: EdgeInsets.only(top: 100),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child:  IconButton(
                              splashRadius: 50,
                              iconSize: 70,
                              onPressed: switchToSettings,
                              icon: const Icon(Icons.settings, color: Colors.white,),
                            ),

                          ),
                        )

                      ],
                    ),
                  ),

                ),
              ) ,
              child: _pages.elementAt(_value),
            ),
          )
      );


  }

  void switchToVideos() {
    setState(() {
      _value = _pages.indexOf(_videosPage);
    });
  }

  void switchToEstimator() {
    setState(() {
      _value = _pages.indexOf(_estimatorPage);
    });
  }

  void switchToSettings() {
    setState(() {
      _value = _pages.indexOf(_settingsPage);
    });
  }



}




