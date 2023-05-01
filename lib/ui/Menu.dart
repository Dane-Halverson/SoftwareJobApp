import 'package:final_project/ui/CostEstimatorView.dart';
import 'package:final_project/ui/VideosView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../city/views/city_stats_browser.dart';

class Menu extends StatelessWidget{
  const Menu({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MenuStatefulWidget(key: super.key),
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
    _pages.add(CityStatsBrowser());
  }



  @override
  Widget build(BuildContext context) {
      return
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 52),
            child: SliderDrawer(
              appBar: SliderAppBar(
                title: Text(
                  'Final Project',
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ),
              slider: Container(color: Theme.of(context).colorScheme.background,
               child: Padding(
                 padding: const EdgeInsets.symmetric(vertical: 50),
                 child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children:
                 [
                   TextButton.icon(
                     onPressed: () {
                       setState(() {
                         _value = 2;
                       });
                     },
                     label: const Text('Browse Cities',),
                     icon: const Icon(
                       Icons.browse_gallery,
                       size: 32.0
                     )
                   ),
                   TextButton.icon(
                     onPressed: switchToVideos,
                     label: const Text("Videos",),
                      icon: const Icon(
                        Icons.play_arrow,
                        size: 32.0
                      )
                   ),
                   TextButton.icon(
                     onPressed: switchToEstimator,
                     label: const Text("Cost Estimator",),
                      icon: const Icon(
                       Icons.money,
                       size: 32.0
                      )
                   )
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




