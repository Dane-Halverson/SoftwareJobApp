import 'dart:ffi';

import 'package:final_project/Index.dart';
import 'package:final_project/VideosList.dart';
import 'package:flutter/material.dart';
import 'models/VideosModel.dart';
//import 'package:units/presenters/CalculatorPresenter.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VideosStatefulWidget(key: super.key),
    );
  }
}

class VideosStatefulWidget extends StatefulWidget {
  const VideosStatefulWidget({super.key});

  @override
  State<VideosStatefulWidget> createState() => _VideosStatefulWidgetState();
}

class _VideosStatefulWidgetState extends State<VideosStatefulWidget> {

  final VideosModel model = VideosModel();

  final List<Widget> _pages = <Widget>[];


  late final List<VideosList> _options = model.videos;

  int? _value;

  @override
  void initState() {
    super.initState();
    _value = model.videos[0].videos.isNotEmpty ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {

    YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: model.videos[0].videos.isNotEmpty ? model.videos.first.videos.first.id :
    model.videos[1].videos.first.id,
    flags: const YoutubePlayerFlags(
    autoPlay: false,
    mute: false,
    ));

    _pages.clear();
    for (int j =0; j < model.videos[0].videos.length; ++j) {
      if (!model.videos[0].videos[j].isFavorite) {
        model.videos[0].videos.removeAt(j);
      }
    }

    for (int i = 0; i < model.videos.length; ++i) {
      _pages.add(
          ListView(
            children: List<Widget>.generate(
                model.videos[i].videos.length, (int index) {

              return model.videos[i].videos.isNotEmpty? GestureDetector(
                  onTap: () {
                    controller.load(model.videos[i].videos[index].id);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(),
                              borderRadius:
                              BorderRadius.circular(20.0), //<-- SEE HERE
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.play_arrow_outlined,
                                  size: 40,
                                ),
                                Expanded(
                                  child: Text(
                                    model.videos[i].videos[index].title,
                                    style: const TextStyle(
                                      //color: Colors.white,
                                      fontFamily: "WorkSans",
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Padding(padding: EdgeInsets.only(right: 8, left: 0),
                      child:  IconButton(
                        onPressed: () {
                          setState(() {
                            model.videos[i].videos[index].isFavorite = !model
                                .videos[i].videos[index].isFavorite;
                            if(model.videos[i].videos[index].isFavorite) {
                              model.videos[0].videos.add(
                                  model.videos[i].videos[index]
                              );
                            }
                          });
                        },
                        icon: model.videos[i].videos[index].isFavorite
                            ? const Icon(Icons.favorite, color: Colors.red, size: 40,)
                            : const Icon(Icons.favorite_border, size: 40,),
                      ),
                      )

                    ],
                  )) : const Text("Nothing to show");
            }),
          )
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Videos",
          ),
        ),
        body: Column(children: [
          YoutubePlayer(
            controller: controller,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List<Widget>.generate(_options.length, (int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(_options[index].type),
                      selected: _value == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = index;
                        });
                      },
                    ),
                  );
                }),
              )),
          Expanded(child: _pages.elementAt(_value!)),
        ]));
  }


}
