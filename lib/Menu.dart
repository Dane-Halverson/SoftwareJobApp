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

  @override
  Widget build(BuildContext context) {
      return
        Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 52),
            child: SliderDrawer(
              appBar: SliderAppBar(
                  appBarColor: Colors.white,
                  title: Text("test",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700))),
              slider: Container(color: Colors.blue),
              child: Container(),
            ),
          )
          

      
      );


  }

}