import 'package:final_project/CostEstimatorView.dart';
import 'package:final_project/VideosView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Menu extends StatelessWidget{
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

  //pages
  final _videosPage = VideosView();
  final _estimatorPage = CostEstimatorView();

  @override
  void initState() {
    super.initState();
    _pages.add(_videosPage);
    _pages.add(_estimatorPage);
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
              slider: Container(color: Colors.blue,
               child: Padding(
                 padding: const EdgeInsets.symmetric(vertical: 50),
                 child: Column(
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

                       ))
                 ],
               ),
               ),

              ),
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

}



